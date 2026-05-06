import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../../home/presentation/widgets/recipe_card.dart';
import '../providers/recipe_provider.dart';

class RecipeDetailPage extends ConsumerStatefulWidget {
  final String id;

  const RecipeDetailPage({super.key, required this.id});

  @override
  ConsumerState<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends ConsumerState<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  @override
  void didUpdateWidget(covariant RecipeDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _loadRecipe();
    }
  }

  void _loadRecipe() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(recipeControllerProvider.notifier).load(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = ref.watch(recipeControllerProvider);
    final recipe = state.maybeWhen(
      data: (recipe) => recipe,
      orElse: () => null,
    );
    final canEditRecipe = recipe != null && recipe.id == widget.id;

    return Scaffold(
      body: state.when(
        loading: () => Scaffold(
          appBar: AppBar(title: Text(t.recipe)),
          body: Center(child: AppStatePanel.loading(title: t.loadingRecipes)),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: Text(t.recipe)),
          body: Center(
            child: AppStatePanel(
              icon: CupertinoIcons.exclamationmark_triangle,
              title: t.couldNotLoadRecipes,
              message: e.toString(),
            ),
          ),
        ),
        data: (recipe) {
          if (recipe == null || recipe.id != widget.id) {
            return Scaffold(
              appBar: AppBar(title: Text(t.recipe)),
              body: Center(child: AppStatePanel.loading(title: t.loadingRecipes)),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar.medium(
                title: Text(recipe.title),
                actions: [
                  if (canEditRecipe)
                    IconButton(
                      tooltip: t.editRecipe,
                      onPressed: () =>
                          context.push(RouteNames.recipeEditor, extra: recipe),
                      icon: const Icon(CupertinoIcons.pencil),
                    ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                    vertical: AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        t.ingredients,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ingredient = recipe.ingredients[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          dense: true,
                          title: Text(ingredient.displayName),
                        ),
                      );
                    },
                    childCount: recipe.ingredients.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        t.steps,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final step = recipe.steps[index];
                      final duration = step.duration == null
                          ? null
                          : friendlyDurationLabel(
                              t, Duration(seconds: step.duration!));

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.instruction,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  if (duration != null) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.timer,
                                          size: 14,
                                          color: theme.colorScheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          duration,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: recipe.steps.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: AppSpacing.huge +
                      MediaQuery.of(context).padding.bottom,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
