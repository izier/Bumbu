import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/tokens/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import 'layout/glass_container.dart';

class FeaturePlaceholderPage extends StatelessWidget {
  const FeaturePlaceholderPage({
    super.key,
    required this.title,
    this.icon = CupertinoIcons.hammer_fill,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
                    theme.colorScheme.surface,
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 64,
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          t.featureComingSoon,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'We are building something special for $title. Check back soon for the full experience!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
