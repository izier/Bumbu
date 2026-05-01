import 'package:bumbu/app/theme/app_theme.dart';
import 'package:bumbu/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../l10n/app_localizations.dart';

final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});

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
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Row(
                        children: [
                          Text('🇺🇸'),
                          SizedBox(width: 8),
                          Text('EN'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: Locale('id'),
                      child: Row(
                        children: [
                          Text('🇮🇩'),
                          SizedBox(width: 8),
                          Text('ID'),
                        ],
                      ),
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
                  child: Image.asset(
                    AppConstants.logobgprimary,
                    width: 200,
                  ),
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
                  Chip(label: Text(t.discovery)),
                  Chip(label: Text(t.social)),
                  Chip(label: Text(t.recipes)),
                  Chip(label: Text(t.pantry)),
                  Chip(label: Text(t.shopping)),
                  Chip(label: Text(t.cookingMode)),
                  Chip(label: Text(t.personalization)),
                ],
              ),

              const SizedBox(height: AppSpacing.sectionSpacing),

              ElevatedButton(
                onPressed: () {
                  // go() replaces the current route so matchedLocation is
                  // correctly /auth. push() stacks auth on top of landing,
                  // leaving matchedLocation as /landing — which breaks the
                  // router redirect guards (errors redirect to landing instead
                  // of staying on auth).
                  context.go(RouteNames.auth);
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