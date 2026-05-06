import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';
import '../shared/providers/app_settings_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme_data.dart';
import 'theme/app_theme_extension.dart';

class BumbuApp extends ConsumerWidget {
  const BumbuApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      theme: appLightTheme.copyWith(extensions: [AppThemeExtension.light]),
      darkTheme: appDarkTheme.copyWith(extensions: [AppThemeExtension.dark]),
      themeMode: ref.watch(themeModeProvider),
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('id')],
      locale: ref.watch(localeProvider),
    );
  }
}
