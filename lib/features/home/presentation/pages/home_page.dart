import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_radius.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../../recipe/data/models/recipe_model.dart';
import '../../../recipe/domain/entities/recipe.dart';
import '../widgets/recipe_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();
  final List<Recipe> _recipes = [];

  DocumentSnapshot<Map<String, dynamic>>? _lastDocument;
  var _isLoading = false;
  var _hasMore = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreNearBottom);
    _loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreNearBottom() {
    if (_scrollController.position.extentAfter > 360) return;
    _loadMore();
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      var query = FirebaseFirestore.instance
          .collection('recipes')
          .orderBy('createdAt', descending: true)
          .limit(10);

      final lastDocument = _lastDocument;
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();
      final recipes = snapshot.docs
          .map((doc) => RecipeModel.fromMap(doc.id, doc.data()))
          .toList();

      if (!mounted) return;
      setState(() {
        _recipes.addAll(recipes);
        _lastDocument = snapshot.docs.isEmpty
            ? _lastDocument
            : snapshot.docs.last;
        _hasMore = snapshot.docs.length == 10;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _refreshRecipes() async {
    if (_isLoading) return;

    setState(() {
      _recipes.clear();
      _lastDocument = null;
      _hasMore = true;
      _error = null;
    });
    await _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: _refreshRecipes,
        edgeOffset: MediaQuery.of(context).padding.top + 56,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar.large(
              title: Text(t.home),
              actions: [
                IconButton(
                  tooltip: t.searchTitle,
                  onPressed: () => context.push(RouteNames.search),
                  icon: const Icon(CupertinoIcons.search),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.sm,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  t.recipes,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_error != null && _recipes.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: AppStatePanel(
                        icon: CupertinoIcons.exclamationmark_triangle,
                        title: t.couldNotLoadRecipes,
                        message: t.couldNotLoadRecipes,
                        action: OutlinedButton(
                          onPressed: _loadMore,
                          child: Text(t.tryAgain),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else if (_recipes.isEmpty && !_isLoading)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: AppStatePanel(
                        icon: CupertinoIcons.search,
                        title: t.noRecipesFound,
                        message: t.tryAnotherSearchOrAddRecipe,
                      ),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  0,
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                ),
                sliver: SliverList.separated(
                  itemCount: _recipes.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final recipe = _recipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () =>
                          context.push(RouteNames.recipeDetailPath(recipe.id)),
                    );
                  },
                ),
              ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                _recipes.isEmpty ? 0 : AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.huge + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverToBoxAdapter(
                child: _LoadMoreFooter(
                  isLoading: _isLoading,
                  hasMore: _hasMore,
                  error: _error,
                  onLoadMore: _loadMore,
                  t: t,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final Object? error;
  final VoidCallback onLoadMore;
  final AppLocalizations t;

  const _LoadMoreFooter({
    required this.isLoading,
    required this.hasMore,
    required this.error,
    required this.onLoadMore,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return Center(
        child: AppStatePanel.loading(title: t.loadingRecipes, compact: true),
      );
    }

    if (error != null) {
      return Center(
        child: OutlinedButton.icon(
          onPressed: onLoadMore,
          icon: const Icon(CupertinoIcons.arrow_clockwise),
          label: Text(t.loadTenMore),
        ),
      );
    }

    if (!hasMore) {
      return Center(
        child: Text(
          t.allCaughtUp,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppRadius.cardRadius,
          color: theme.colorScheme.surfaceContainerHighest,
        ),
        child: TextButton.icon(
          onPressed: onLoadMore,
          icon: const Icon(CupertinoIcons.arrow_up),
          label: Text(t.pullUpToLoadTenMore),
        ),
      ),
    );
  }
}
