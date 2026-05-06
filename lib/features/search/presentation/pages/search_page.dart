import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/recipe_card.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../../profile/presentation/providers/social_provider.dart';
import '../../../recipe/data/models/recipe_model.dart';
import '../../../recipe/domain/entities/recipe.dart';

/// Centers empty/error messaging and keeps line length readable on wide layouts.
Widget _searchMessageShell({required Widget child}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: child,
      ),
    ),
  );
}

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();
  final _recipeScrollController = ScrollController();

  final List<Recipe> _recipes = [];
  DocumentSnapshot<Map<String, dynamic>>? _lastRecipeDoc;
  Timer? _searchDebounce;
  var _query = '';
  var _isDebouncing = false;
  var _recipeLoading = false;
  var _recipeHasMore = true;
  Object? _recipeError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _recipeScrollController.addListener(_onRecipeScroll);
    _loadMoreRecipes();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _tabController.dispose();
    _searchController.dispose();
    _recipeScrollController.dispose();
    super.dispose();
  }

  void _onRecipeScroll() {
    if (_tabController.index != 1) return;
    if (_recipeScrollController.position.extentAfter > 360) return;
    _loadMoreRecipes();
  }

  Future<void> _loadMoreRecipes() async {
    if (_recipeLoading || !_recipeHasMore) return;
    setState(() {
      _recipeLoading = true;
      _recipeError = null;
    });
    try {
      var q = FirebaseFirestore.instance
          .collection('recipes')
          .orderBy('createdAt', descending: true)
          .limit(12);

      final last = _lastRecipeDoc;
      if (last != null) {
        q = q.startAfterDocument(last);
      }

      final snapshot = await q.get();
      final batch = snapshot.docs
          .map((doc) => RecipeModel.fromMap(doc.id, doc.data()))
          .toList();

      if (!mounted) return;
      setState(() {
        _recipes.addAll(batch);
        _lastRecipeDoc =
            snapshot.docs.isEmpty ? _lastRecipeDoc : snapshot.docs.last;
        _recipeHasMore = snapshot.docs.length == 12;
      });
    } catch (e) {
      if (mounted) setState(() => _recipeError = e);
    } finally {
      if (mounted) setState(() => _recipeLoading = false);
    }
  }

  List<Recipe> get _filteredRecipes {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _recipes.where((recipe) {
      final haystack =
          '${recipe.title} ${recipe.description} '
                  '${recipe.ingredients.map((e) => e.displayName).join(' ')}'
              .toLowerCase();
      return haystack.contains(q);
    }).toList();
  }

  List<UserProfile> _filteredUsers(List<UserProfile> profiles) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return profiles.where((profile) {
      final haystack = '${profile.username} ${profile.displayName}'.toLowerCase();
      return haystack.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final profilesAsync = ref.watch(userProfilesProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: Text(t.searchTitle),
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.md,
              AppSpacing.screenPadding,
              AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: SearchBar(
                controller: _searchController,
                leading: Icon(
                  CupertinoIcons.search,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                hintText: t.searchPeopleAndRecipes,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _searchDebounce?.cancel();
                    setState(() {
                      _query = '';
                      _isDebouncing = false;
                    });
                    return;
                  }
                  setState(() => _isDebouncing = true);
                  _searchDebounce?.cancel();
                  _searchDebounce =
                      Timer(const Duration(milliseconds: 600), () {
                    if (mounted) {
                      setState(() {
                        _query = value;
                        _isDebouncing = false;
                      });
                    }
                  });
                },
                trailing: [
                  if (_isDebouncing)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  if (_query.isNotEmpty || _searchController.text.isNotEmpty)
                    IconButton(
                      tooltip: t.cancel,
                      onPressed: () {
                        _searchDebounce?.cancel();
                        _searchController.clear();
                        setState(() {
                          _query = '';
                          _isDebouncing = false;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              child: Container(
                color: theme.colorScheme.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                  vertical: AppSpacing.xs,
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: t.tabAccounts),
                    Tab(text: t.tabRecipes),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _AccountsTabBody(
              query: _query,
              profilesAsync: profilesAsync,
              filter: _filteredUsers,
              t: t,
            ),
            _RecipesTabBody(
              query: _query,
              recipes: _filteredRecipes,
              isLoading: _recipeLoading,
              error: _recipeError,
              hasBaseList: _recipes.isNotEmpty,
              onRetry: _loadMoreRecipes,
              scrollController: _recipeScrollController,
              t: t,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverTabBarDelegate({required this.child});

  @override
  double get minExtent => 52;
  @override
  double get maxExtent => 52;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}

class _AccountsTabBody extends StatelessWidget {
  final String query;
  final AsyncValue<List<UserProfile>> profilesAsync;
  final List<UserProfile> Function(List<UserProfile>) filter;
  final AppLocalizations t;

  const _AccountsTabBody({
    required this.query,
    required this.profilesAsync,
    required this.filter,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return profilesAsync.when(
      loading: () => _searchMessageShell(
        child: AppStatePanel.loading(title: t.loading),
      ),
      error: (e, _) => _searchMessageShell(
        child: AppStatePanel(
          icon: CupertinoIcons.exclamationmark_triangle,
          title: t.errorSomethingWentWrong,
          message: e.toString(),
        ),
      ),
      data: (profiles) {
        final trimmed = query.trim();
        if (trimmed.isEmpty) {
          return _searchMessageShell(
            child: AppStatePanel(
              icon: CupertinoIcons.person_2,
              title: t.searchTitle,
              message: t.searchCreatorsEngage,
            ),
          );
        }
        final users = filter(profiles);
        if (users.isEmpty) {
          return _searchMessageShell(
            child: AppStatePanel(
              icon: CupertinoIcons.person_crop_circle_badge_xmark,
              title: t.noSearchResults,
              message: t.searchCreatorsEngage,
            ),
          );
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            AppSpacing.groupedPadding,
            AppSpacing.sm,
            AppSpacing.groupedPadding,
            AppSpacing.huge + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: users.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, i) => _SearchUserTile(
            profile: users[i],
            onTap: () => context.push(
              '${RouteNames.search}/user-profile',
              extra: users[i],
            ),
          ),
        );
      },
    );
  }
}

class _RecipesTabBody extends StatelessWidget {
  final String query;
  final List<Recipe> recipes;
  final bool isLoading;
  final Object? error;
  final bool hasBaseList;
  final VoidCallback onRetry;
  final ScrollController scrollController;
  final AppLocalizations t;

  const _RecipesTabBody({
    required this.query,
    required this.recipes,
    required this.isLoading,
    required this.error,
    required this.hasBaseList,
    required this.onRetry,
    required this.scrollController,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return _searchMessageShell(
        child: AppStatePanel(
          icon: CupertinoIcons.book,
          title: t.searchTitle,
          message: t.searchRecipesEngage,
        ),
      );
    }

    if (error != null && !hasBaseList) {
      return _searchMessageShell(
        child: AppStatePanel(
          icon: CupertinoIcons.exclamationmark_triangle,
          title: t.couldNotLoadRecipes,
          action: OutlinedButton(
            onPressed: onRetry,
            child: Text(t.tryAgain),
          ),
        ),
      );
    }

    if (recipes.isEmpty && !isLoading) {
      return _searchMessageShell(
        child: AppStatePanel(
          icon: CupertinoIcons.doc_text_search,
          title: t.noRecipesFound,
          message: t.tryAnotherSearchOrAddRecipe,
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.groupedPadding,
        AppSpacing.sm,
        AppSpacing.groupedPadding,
        AppSpacing.huge + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: recipes.length + (isLoading ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index >= recipes.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: AppStatePanel.loading(title: t.loadingRecipes, compact: true),
          );
        }
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () => context.push(RouteNames.recipeDetailPath(recipe.id)),
        );
      },
    );
  }
}

class _SearchUserTile extends ConsumerWidget {
  final UserProfile profile;
  final VoidCallback onTap;

  const _SearchUserTile({required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final currentUser = ref.watch(authStateProvider);
    final socialService = ref.read(socialServiceProvider);
    final canFollow = currentUser != null && currentUser.id != profile.id;

    final followState = canFollow
        ? ref.watch(isFollowingProvider((
            followerId: currentUser.id,
            followingId: profile.id,
          )))
        : null;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(CupertinoIcons.person_fill)),
        title: Text(profile.displayName),
        subtitle: Text('@${profile.username}'),
        trailing: canFollow
            ? followState?.when(
                data: (isFollowing) => FilledButton.tonal(
                  onPressed: () => socialService.toggleFollow(
                    followerId: currentUser.id,
                    followingId: profile.id,
                    currentlyFollowing: isFollowing,
                  ),
                  child: Text(isFollowing ? t.following : t.follow),
                ),
                error: (_, _) => Icon(CupertinoIcons.clear, size: 16),
                loading: () => const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
      ),
    );
  }
}
