// pantry_screen.dart

import 'package:bumbu/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/pantry_provider.dart';
import '../widgets/ingredient_item.dart';
import '../widgets/add_ingredient_card.dart';
import '../widgets/insight_header.dart';

class PantryScreen extends ConsumerStatefulWidget {
  const PantryScreen({super.key});

  @override
  ConsumerState<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends ConsumerState<PantryScreen>
    with SingleTickerProviderStateMixin {
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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: false,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                title: Image.asset(
                  AppConstants.logoWordmark,
                  width: 96,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              /// ✨ INSIGHT (Main intelligence layer)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    child: InsightHeader(items: items),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              /// ➕ ADD INGREDIENT (Primary action)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AddIngredientCard(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              /// 🧂 LIST OR EMPTY STATE
              items.isEmpty
                  ? const SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(),
              )
                  : SliverPadding(
                padding: const EdgeInsets.only(bottom: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = items[index];

                      return TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration:
                        Duration(milliseconds: 300 + (index * 50)),
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
                        child: IngredientItem(
                          ingredient: item,
                          index: index,
                        ),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🍳 ICON WITH LIFE
          Container(
            padding: const EdgeInsets.all(20),
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
      ),
    );
  }
}
