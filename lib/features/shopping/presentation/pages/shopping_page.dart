import 'package:bumbu/features/shopping/presentation/widgets/shopping_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/shopping_provider.dart';
import '../widgets/add_shopping_card.dart';

class ShoppingPage extends ConsumerStatefulWidget {
  const ShoppingPage({super.key});

  @override
  ConsumerState<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends ConsumerState<ShoppingPage> {
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
      ref.read(shoppingProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(shoppingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// ➕ STICKY ADD SHOPPING
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyAddShoppingDelegate(
                  isExpanded: _isExpanded,
                  onToggle: _toggleExpand,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              /// 🧾 LIST / EMPTY
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
                      child: ShoppingItemTile(
                        item: item,
                        index: index,
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined,
              size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text("Nothing here yet", style: TextStyle(fontSize: 16)),
          SizedBox(height: 4),
          Text("Add ingredients to get started",
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

/// 🔥 STICKY HEADER (SAFE FIXED HEIGHT)
class _StickyAddShoppingDelegate extends SliverPersistentHeaderDelegate {
  final bool isExpanded;
  final VoidCallback onToggle;

  _StickyAddShoppingDelegate({
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  double get minExtent =>  isExpanded ? 222 : 150;

  @override
  double get maxExtent =>  isExpanded ? 222 : 150;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFF7F6F3),
      child: AddShoppingCard(
        expanded: isExpanded,
        onToggle: onToggle,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyAddShoppingDelegate oldDelegate) {
    return oldDelegate.isExpanded != isExpanded;
  }
}