import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../../../shared/widgets/layout/glass_container.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/recipe_card.dart';
import '../../../recipe/presentation/providers/recipe_provider.dart';
import '../providers/social_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(authStateProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.profile)),
        body: Center(
          child: AppStatePanel(
            icon: CupertinoIcons.person_crop_circle_badge_exclam,
            title: t.notAuthenticated,
          ),
        ),
      );
    }

    final recipesAsync = ref.watch(userRecipesProvider(user.id));

    return Scaffold(
      body: recipesAsync.when(
        data: (recipes) => RefreshIndicator.adaptive(
          onRefresh: () async => ref.refresh(userRecipesProvider(user.id)),
          edgeOffset: MediaQuery.of(context).padding.top + 56,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar.large(
                title: Text(t.profile),
                actions: [
                  IconButton(
                    tooltip: t.settings,
                    onPressed: () => context.push(RouteNames.profileMenu),
                    icon: const Icon(CupertinoIcons.line_horizontal_3),
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                sliver: SliverToBoxAdapter(
                  child: _ProfileHeader(user: user, recipeCount: recipes.length),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: FilledButton.icon(
                      onPressed: () => context.push(RouteNames.recipeEditor),
                      icon: const Icon(CupertinoIcons.pencil),
                      label: Text(t.createRecipe),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  0,
                  AppSpacing.screenPadding,
                  AppSpacing.huge,
                ),
                sliver: recipes.isEmpty
                    ? SliverToBoxAdapter(
                        child: AppStatePanel(
                          icon: CupertinoIcons.doc_text,
                          title: t.profileNoRecipesYetTitle,
                          message: t.profileNoRecipesYetBody,
                        ),
                      )
                    : SliverList.separated(
                        itemCount: recipes.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () => context
                                .push(RouteNames.recipeDetailPath(recipe.id)),
                          );
                        },
                      ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom +
                        AppSpacing.md),
              ),
            ],
          ),
        ),
        loading: () => Scaffold(
          appBar: AppBar(title: Text(t.profile)),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Scaffold(
          appBar: AppBar(title: Text(t.profile)),
          body: AppStatePanel.error(
            title: t.errorSomethingWentWrong,
            message: err.toString(),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  final AppUser user;
  final int recipeCount;

  const _ProfileHeader({
    required this.user,
    required this.recipeCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final statsAsync = ref.watch(userStatsProvider(user.id));

    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 36,
            child: Icon(CupertinoIcons.person_fill, size: 34),
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName.isEmpty ? user.email : user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
                if (user.username.isNotEmpty) ...[
                  Text(
                    '@${user.username}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                statsAsync.when(
                  data: (stats) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatItem(
                        label: t.statRecipes,
                        value: recipeCount,
                      ),
                      _StatItem(
                        label: t.statFollowers,
                        value: stats.followers,
                        onTap: () => context.push(
                          '/profile/followers/${user.id}?title=${t.statFollowers}',
                        ),
                      ),
                      _StatItem(
                        label: t.statFollowing,
                        value: stats.following,
                        onTap: () => context.push(
                          '/profile/following/${user.id}?title=${t.statFollowing}',
                        ),
                      ),
                    ],
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback? onTap;

  const _StatItem({
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$value', style: theme.textTheme.titleMedium),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
