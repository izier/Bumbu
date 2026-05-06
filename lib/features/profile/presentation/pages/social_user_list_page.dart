import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
import '../../domain/entities/user_profile.dart';

class SocialUserListPage extends ConsumerWidget {
  final String title;
  final AsyncValue<List<UserProfile>> usersAsync;

  const SocialUserListPage({
    super.key,
    required this.title,
    required this.usersAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar.medium(
            title: Text(title),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: AppSpacing.huge + MediaQuery.of(context).padding.bottom,
            ),
            sliver: usersAsync.when(
              data: (users) {
                if (users.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: AppStatePanel(
                        icon: CupertinoIcons.person_2,
                        title: t.noSearchResults,
                        compact: true,
                      ),
                    ),
                  );
                }
                return SliverList.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                        vertical: AppSpacing.xs,
                      ),
                      leading: const CircleAvatar(
                        child: Icon(CupertinoIcons.person_fill),
                      ),
                      title: Text(user.displayName),
                      subtitle: Text('@${user.username}'),
                      trailing: const Icon(CupertinoIcons.chevron_forward, size: 16),
                      onTap: () => context.push(
                        RouteNames.userProfilePath(user.id),
                        extra: user,
                      ),
                    );
                  },
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => SliverFillRemaining(
                child: AppStatePanel.error(
                  title: t.errorSomethingWentWrong,
                  message: err.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
