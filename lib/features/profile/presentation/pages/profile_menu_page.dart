import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/tokens/app_radius.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../app/router/route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/app_settings_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileMenuPage extends ConsumerWidget {
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(authStateProvider);
    final notifier = ref.read(authStateProvider.notifier);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar.large(
            title: Text(t.settings),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.base,
              AppSpacing.screenPadding,
              AppSpacing.huge + MediaQuery.of(context).padding.bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.cardRadius,
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(CupertinoIcons.person_fill),
                    ),
                    title: Text(user?.email ?? t.notAuthenticated),
                    subtitle: Text(t.profile),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.cardRadius,
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  child: ListTile(
                    leading: const Icon(CupertinoIcons.pencil),
                    title: Text(t.editProfile),
                    trailing:
                        const Icon(CupertinoIcons.chevron_forward, size: 18),
                    onTap: user == null
                        ? null
                        : () => context.push(RouteNames.editProfile),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _SettingsSection(
                  title: t.language,
                  child: CupertinoSlidingSegmentedControl<Locale>(
                    groupValue: locale,
                    children: {
                      const Locale('en'): Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(t.english),
                      ),
                      const Locale('id'): Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(t.indonesian),
                      ),
                    },
                    onValueChanged: (value) {
                      if (value == null) return;
                      ref.read(localeProvider.notifier).state = value;
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _SettingsSection(
                  title: t.theme,
                  child: CupertinoSlidingSegmentedControl<ThemeMode>(
                    groupValue: themeMode,
                    children: {
                      ThemeMode.system: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(t.systemTheme),
                      ),
                      ThemeMode.light: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(t.lightTheme),
                      ),
                      ThemeMode.dark: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(t.darkTheme),
                      ),
                    },
                    onValueChanged: (value) {
                      if (value == null) return;
                      ref.read(themeModeProvider.notifier).state = value;
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                FilledButton.tonalIcon(
                  onPressed: () async {
                    await notifier.logout();
                    if (context.mounted) context.go('/');
                  },
                  icon: const Icon(CupertinoIcons.square_arrow_right),
                  label: Text(t.logout),
                ),
              ]),
            ),
          ),
        ],
      ),
    );

  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.cardRadius,
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Center(child: child),
          ],
        ),
      ),
    );
  }
}
