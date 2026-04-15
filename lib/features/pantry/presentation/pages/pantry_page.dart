import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/pantry_provider.dart';
import '../widgets/ingredient_item_tile.dart';
import '../widgets/add_ingredient_card.dart';
import '../widgets/insight_header.dart';

class PantryPage extends ConsumerStatefulWidget {
  const PantryPage({super.key});

  @override
  ConsumerState<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends ConsumerState<PantryPage>
    with SingleTickerProviderStateMixin {

  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(pantryProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {

    final items = ref.watch(pantryProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [

                /// ➕ STICKY ADD INGREDIENT (NEW)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyAddIngredientDelegate(
                    isExpanded: _isExpanded,
                    onToggle: _toggleExpand,
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                /// ✨ INSIGHT (NOW BELOW)
                SliverToBoxAdapter(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    child: InsightHeader(items: items),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                /// 🧂 LIST OR EMPTY STATE
                items.isEmpty
                    ? const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(),
                ) : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 300 + (index * 50)),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                          },
                        child: IngredientItemTile(
                          ingredient: item,
                          index: index,
                        ),
                      );
                      },
                    childCount: items.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 🍳 ICON WITH LIFE
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
          ),
          child: Icon(
            Icons.kitchen_rounded,
            size: 42,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 20),

        /// 💬 EMOTIONAL TEXT
        Text(
          "Your kitchen is waiting",
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          "Add a few ingredients to fill your pantry.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _StickyAddIngredientDelegate extends SliverPersistentHeaderDelegate {
  final bool isExpanded;
  final VoidCallback onToggle;

  _StickyAddIngredientDelegate({
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  double get minExtent => isExpanded ? 222 : 150;

  @override
  double get maxExtent => isExpanded ? 222 : 150; // 🔥 dynamic height

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final availableHeight = (maxExtent - shrinkOffset)
        .clamp(minExtent, maxExtent);

    return SizedBox(
      height: availableHeight,
      child:  AddIngredientCard(
        expanded: isExpanded,
        onToggle: onToggle,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyAddIngredientDelegate oldDelegate) {
    return oldDelegate.isExpanded != isExpanded;
  }
}