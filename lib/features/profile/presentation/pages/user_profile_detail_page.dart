import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_radius.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../../../shared/widgets/layout/glass_container.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/recipe_card.dart';
import '../../../recipe/presentation/providers/recipe_provider.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/social_provider.dart';

class UserProfileDetailPage extends ConsumerWidget {
  final UserProfile profile;

  const UserProfileDetailPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final currentUser = ref.watch(authStateProvider);
    final isMe = currentUser?.id == profile.id;

    final recipesAsync = ref.watch(userRecipesProvider(profile.id));

    return Scaffold(
      body: recipesAsync.when(
        data: (recipes) => CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar.medium(
              title: Text(profile.displayName),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.base,
                AppSpacing.screenPadding,
                AppSpacing.huge + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _PublicProfileHeader(
                          profile: profile,
                          recipeCount: recipes.length,
                          isMe: isMe,
                        ),
                      );
                    }

                    if (index == 1) {
                      if (recipes.isEmpty) {
                        return AppStatePanel(
                          icon: CupertinoIcons.doc_text,
                          title: isMe ? t.profileNoRecipesYetTitle : t.publicProfileNoRecipes,
                          message: isMe ? t.profileNoRecipesYetBody : t.publicProfileNoRecipesDetail,
                          compact: true,
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    final recipe = recipes[index - 2];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: RecipeCard(
                        recipe: recipe,
                        onTap: () => context
                            .push(RouteNames.recipeDetailPath(recipe.id)),
                      ),
                    );
                  },
                  childCount: recipes.length + 2,
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => AppStatePanel.error(
          title: t.errorSomethingWentWrong,
          message: err.toString(),
        ),
      ),
    );
  }
}

class _PublicProfileHeader extends ConsumerWidget {
  final UserProfile profile;
  final int recipeCount;
  final bool isMe;

  const _PublicProfileHeader({
    required this.profile,
    required this.recipeCount,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final currentUser = ref.watch(authStateProvider);
    
    final statsAsync = ref.watch(userStatsProvider(profile.id));
    
    AsyncValue<bool>? isFollowingAsync;
    if (!isMe && currentUser != null) {
      isFollowingAsync = ref.watch(isFollowingProvider((
        followerId: currentUser.id,
        followingId: profile.id,
      )));
    }

    return Column(
      children: [
        GlassContainer(
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
                      profile.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '@${profile.username}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    statsAsync.when(
                      data: (stats) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StatItem(
                            label: t.statRecipes,
                            value: recipeCount,
                            onTap: null,
                          ),
                          _StatItem(
                            label: t.statFollowers,
                            value: stats.followers,
                            onTap: () => context.push(
                              '/profile/followers/${profile.id}?title=${t.statFollowers}',
                            ),
                          ),
                          _StatItem(
                            label: t.statFollowing,
                            value: stats.following,
                            onTap: () => context.push(
                              '/profile/following/${profile.id}?title=${t.statFollowing}',
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
        ),
        if (!isMe && currentUser != null && isFollowingAsync != null) ...[
          const SizedBox(height: AppSpacing.md),
          isFollowingAsync.when(
            data: (isFollowing) => SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: isFollowing
                    ? FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        foregroundColor: theme.colorScheme.onSurfaceVariant,
                      )
                    : null,
                onPressed: () => ref.read(socialServiceProvider).toggleFollow(
                      followerId: currentUser.id,
                      followingId: profile.id,
                      currentlyFollowing: isFollowing,
                    ),
                child: Text(isFollowing ? t.following : t.follow),
              ),
            ),
            loading: () => const Center(child: CupertinoActivityIndicator()),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ],
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
      borderRadius: BorderRadius.circular(AppRadius.sm),
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
