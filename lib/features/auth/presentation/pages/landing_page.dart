import 'package:bumbu/app/theme/tokens/app_radius.dart';
import 'package:bumbu/app/theme/tokens/app_spacing.dart';
import 'package:bumbu/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/app_settings_provider.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: DropdownButton<Locale>(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  value: locale,
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Text(t.english),
                    ),
                    DropdownMenuItem(
                      value: const Locale('id'),
                      child: Text(t.indonesian),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).state = value;
                    }
                  },
                ),
              ),

              const Spacer(),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(AppRadius.xl),
                  child: Image.asset(AppConstants.logobgprimary, width: 200),
                ),
              ),

              const Spacer(),

              Center(
                child: Text(
                  t.motto,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              const SizedBox(height: AppSpacing.sectionSpacing),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text(t.discovery),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.social),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.recipes),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.pantry),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.shopping),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.cookingMode),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(t.personalization),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.sectionSpacing),

              ElevatedButton(
                onPressed: () {
                  context.push(RouteNames.auth);
                },
                child: Text(t.getStarted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
