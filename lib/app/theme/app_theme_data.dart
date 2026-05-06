import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tokens/app_animations.dart';
import 'tokens/app_colors.dart';
import 'tokens/app_radius.dart';
import 'tokens/app_spacing.dart';
import 'tokens/app_typography.dart';

//  8. THEME DATA (Light)
// ─────────────────────────────────────────────────────────────────────────────

ThemeData get appLightTheme {
  const primarySwatch = MaterialColor(0xFFFF383C, {
    50: Color(0xFFFFF0F0),
    100: Color(0xFFFFD6D7),
    200: Color(0xFFFFABAC),
    300: Color(0xFFFF8081),
    400: Color(0xFFFF6B6E),
    500: Color(0xFFFF383C),
    600: Color(0xFFE62C30),
    700: Color(0xFFCC1E22),
    800: Color(0xFFB31215),
    900: Color(0xFF99060A),
  });

  return ThemeData(
    canvasColor: AppColors.surfaceLight,
    primarySwatch: primarySwatch,
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTypography.bodyFont,

    // ── Color Scheme ──────────────────────────────────────────────────────
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryLighter,
      onPrimaryContainer: AppColors.primaryDarker,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: Color(0xFFFFEDD0),
      onSecondaryContainer: Color(0xFF7A4000),
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceAlt,
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      outline: AppColors.dividerLight,
      outlineVariant: Color(0xFFF0EFEC),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: AppColors.bgDark,
      onInverseSurface: AppColors.textPrimaryDark,
      inversePrimary: AppColors.primaryLight,
    ),

    // ── Scaffold ──────────────────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.bgLight,

    // ── App Bar ───────────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0, // iOS uses blur, not shadow on scroll
      shadowColor: Colors.transparent,
      // iOS style nav: centered title in standard height bars
      centerTitle: true,
      titleSpacing: AppSpacing.screenPadding,
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.displayFont,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    // ── Bottom Navigation ─────────────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.navActive,
      unselectedItemColor: AppColors.navInactive,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 26),
      unselectedIconTheme: IconThemeData(size: 24),
      selectedLabelStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ── Navigation Bar (Material 3) ────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.navBgLight,
      indicatorColor: AppColors.primarySurface,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.navActive, size: 26);
        }
        return const IconThemeData(color: AppColors.navInactive, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontFamily: AppTypography.bodyFont,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.navActive,
          );
        }
        return const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.navInactive,
        );
      }),
      elevation: 0,
      height: 64,
    ),

    // ── Cards ─────────────────────────────────────────────────────────────
    // iOS 26: flat cards with a hairline inner stroke for depth
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 0,
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: const BorderSide(color: Color(0x0F000000), width: 0.5),
      ),
    ),

    // ── Elevated Buttons ──────────────────────────────────────────────────
    // iOS 26: slightly shorter, shrinkWrap tap target
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const Color(0xFFCCCCCC);
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        overlayColor: WidgetStateProperty.all(const Color(0x1AFFFFFF)),
        elevation: WidgetStateProperty.all(0),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
        ),
        textStyle: WidgetStateProperty.all(AppTypography.buttonLarge),
        animationDuration: AppAnimations.fast,
      ),
    ),

    // ── Outlined Buttons ──────────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(const Color(0x0FFF383C)),
        side: WidgetStateProperty.resolveWith((states) {
          return BorderSide(
            color: states.contains(WidgetState.focused)
                ? AppColors.primary
                : AppColors.dividerLight,
            width: states.contains(WidgetState.focused) ? 1.5 : 1.0,
          );
        }),
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
        ),
        textStyle: WidgetStateProperty.all(
          AppTypography.buttonLarge.copyWith(color: AppColors.primary),
        ),
      ),
    ),

    // ── Text Buttons ──────────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        overlayColor: WidgetStateProperty.all(const Color(0x0FFF383C)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: AppTypography.bodyFont,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),

    // ── Dropdown Menu ─────────────────────────────────────────────────────
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: AppColors.textPrimary),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.surfaceLight),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(4),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAlt.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),

    // ── FAB ───────────────────────────────────────────────────────────────
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 8,
      focusElevation: 10,
      hoverElevation: 12,
      highlightElevation: 6,
      shape: CircleBorder(),
      extendedTextStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),

    // ── Icon Button ───────────────────────────────────────────────────────
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.textPrimary),
        overlayColor: WidgetStateProperty.all(const Color(0x0A000000)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
        minimumSize: WidgetStateProperty.all(const Size(40, 40)),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
        ),
      ),
    ),

    // ── Input / Text Field ────────────────────────────────────────────────
    // iOS 26: softer fill, no border at rest, tighter padding
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceAlt,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      ),
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      floatingLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
      errorStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
      ),
      prefixIconColor: AppColors.textTertiary,
      suffixIconColor: AppColors.textTertiary,
    ),

    // ── Chips ─────────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceAlt,
      selectedColor: AppColors.primaryLighter,
      disabledColor: const Color(0xFFF0F0F0),
      deleteIconColor: AppColors.textSecondary,
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
      side: BorderSide.none,
      elevation: 0,
      pressElevation: 0,
      showCheckmark: false,
    ),

    // ── Divider ───────────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerLight,
      thickness: 1,
      space: 1,
    ),

    // ── List Tile ─────────────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      minLeadingWidth: 0,
      iconColor: AppColors.textSecondary,
      textColor: AppColors.textPrimary,
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
    ),

    // ── Bottom Sheet ──────────────────────────────────────────────────────
    // iOS 26: large top radius (20+), floats up like a glass panel
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceLight,
      modalBackgroundColor: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 24,
      dragHandleColor: Color(0xFFDDDBD8),
      dragHandleSize: Size(40, 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      showDragHandle: true,
    ),

    // ── Dialog ────────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      titleTextStyle: AppTypography.h3,
      contentTextStyle: AppTypography.bodyMedium,
    ),

    // ── Snack Bar ─────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF1A1A1A),
      contentTextStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      actionTextColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
    ),

    // ── Progress Indicators ───────────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.primaryLighter,
      circularTrackColor: AppColors.primaryLighter,
      linearMinHeight: 4,
    ),

    // ── Slider ────────────────────────────────────────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.primaryLighter,
      thumbColor: AppColors.primary,
      overlayColor: const Color(0x20FF383C),
      valueIndicatorColor: AppColors.primaryDark,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      trackHeight: 4,
      valueIndicatorTextStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // ── Switch ────────────────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return const Color(0xFFAAAAAA);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return const Color(0xFFDDDBD8);
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    // ── Checkbox ──────────────────────────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(const Color(0x10FF383C)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(color: AppColors.dividerLight, width: 1.5),
    ),

    // ── Radio ─────────────────────────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.textTertiary;
      }),
      overlayColor: WidgetStateProperty.all(const Color(0x10FF383C)),
    ),

    // ── Tab Bar ───────────────────────────────────────────────────────────
    // iOS 26: pill/capsule indicator instead of underline
    tabBarTheme: TabBarThemeData(
      // Selected: strong hue on soft tint; unselected: neutral (not primary).
      labelColor: AppColors.primaryDarker,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: AppColors.primaryLighter,
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      overlayColor: WidgetStateProperty.all(const Color(0x0AFF383C)),
    ),

    // ── Tooltip ───────────────────────────────────────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xEE1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 12,
        color: Colors.white,
      ),
      waitDuration: const Duration(milliseconds: 600),
    ),

    // ── Badge ─────────────────────────────────────────────────────────────
    badgeTheme: const BadgeThemeData(
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      textStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      largeSize: 20,
      smallSize: 8,
    ),

    // ── Search Bar ────────────────────────────────────────────────────────
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(AppColors.surfaceAlt),
      elevation: WidgetStateProperty.all(0),
      hintStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 15,
          color: AppColors.textTertiary,
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 15,
          color: AppColors.textPrimary,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: AppRadius.inputRadius),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 18),
      ),
    ),

    // ── Popup Menu ────────────────────────────────────────────────────────
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surfaceLight,
      elevation: 8,
      shadowColor: const Color(0x20000000),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      textStyle: AppTypography.bodyMedium,
    ),

    // ── Date Picker ───────────────────────────────────────────────────────
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.surfaceLight,
      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: Colors.white,
      todayBorder: const BorderSide(color: AppColors.primary, width: 1),
      todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
      todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return null;
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return AppColors.textPrimary;
      }),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
    ),

    // ── Time Picker ───────────────────────────────────────────────────────
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.surfaceLight,
      dialBackgroundColor: AppColors.surfaceAlt,
      dialHandColor: AppColors.primary,
      hourMinuteColor: AppColors.surfaceAlt,
      hourMinuteTextColor: AppColors.textPrimary,
      dayPeriodColor: AppColors.surfaceAlt,
      dayPeriodTextColor: AppColors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
    ),

    // ── Typography override ────────────────────────────────────────────────
    textTheme: TextTheme(
      displayLarge: AppTypography.heroTitle.copyWith(
        color: AppColors.textPrimary,
      ),
      displayMedium: AppTypography.h1.copyWith(color: AppColors.textPrimary),
      displaySmall: AppTypography.h2.copyWith(color: AppColors.textPrimary),
      headlineLarge: AppTypography.h2.copyWith(color: AppColors.textPrimary),
      headlineMedium: AppTypography.h3.copyWith(color: AppColors.textPrimary),
      headlineSmall: AppTypography.h4.copyWith(color: AppColors.textPrimary),
      titleLarge: AppTypography.h3.copyWith(color: AppColors.textPrimary),
      titleMedium: AppTypography.h4.copyWith(color: AppColors.textPrimary),
      titleSmall: AppTypography.labelLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: AppColors.textTertiary,
      ),
    ),

    // ── Interaction ───────────────────────────────────────────────────────
    splashColor: const Color(0x0AFF383C),
    highlightColor: const Color(0x06FF383C),
    hoverColor: const Color(0x05FF383C),
    focusColor: const Color(0x0FFF383C),
    splashFactory: InkSparkle.splashFactory,

    // ── Page Transitions ──────────────────────────────────────────────────
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _GrubPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // ── Visual Density ────────────────────────────────────────────────────
    visualDensity: VisualDensity.standard,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  8a. CUSTOM PAGE TRANSITION
//      Slide-up + fade for Android. Snappy 220 ms with easeOut.
//      iOS keeps native CupertinoPageTransitionsBuilder.
// ─────────────────────────────────────────────────────────────────────────────

class _GrubPageTransitionsBuilder extends PageTransitionsBuilder {
  const _GrubPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final enter = CurvedAnimation(
      parent: animation,
      curve: AppAnimations.enter,
      reverseCurve: AppAnimations.exit,
    );
    final secondary = CurvedAnimation(
      parent: secondaryAnimation,
      curve: AppAnimations.exit,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.04, 0),
        end: Offset.zero,
      ).animate(enter),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(enter),
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.85).animate(secondary),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  9. THEME DATA (Dark)
// ─────────────────────────────────────────────────────────────────────────────

ThemeData get appDarkTheme {
  return appLightTheme.copyWith(
    canvasColor: AppColors.surfaceDark,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryDarker,
      onPrimaryContainer: AppColors.primaryLighter,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: Color(0xFF5A3000),
      onSecondaryContainer: Color(0xFFFFDDB5),
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.surfaceAltDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      outline: AppColors.dividerDark,
      outlineVariant: Color(0xFF2A2A2A),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: AppColors.surfaceLight,
      onInverseSurface: AppColors.textPrimary,
      inversePrimary: AppColors.primaryDark,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      titleSpacing: AppSpacing.screenPadding,
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.displayFont,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.3,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimaryDark, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),

    // ── Cards (Dark) ──────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: const BorderSide(color: Color(0x1AFFFFFF), width: 0.5),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceAltDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 15,
        color: AppColors.textTertiaryDark,
      ),
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        color: AppColors.textSecondaryDark,
      ),
      floatingLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
      errorStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 12,
        color: AppColors.error,
      ),
      prefixIconColor: AppColors.textTertiaryDark,
      suffixIconColor: AppColors.textTertiaryDark,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 1,
      space: 1,
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: AppColors.textPrimaryDark),
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.surfaceDark),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shadowColor: const WidgetStatePropertyAll(Colors.black),
        elevation: const WidgetStatePropertyAll(8),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAltDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 15,
          color: AppColors.textTertiaryDark,
        ),
        // ✅ FIX 1: Add these missing dark-mode colors
        labelStyle: const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 14,
          color: AppColors.textSecondaryDark,
        ),
        prefixIconColor: AppColors.textTertiaryDark,
        suffixIconColor: AppColors.textTertiaryDark,
      ),
    ),

    // ── Search Bar (Dark) ─────────────────────────────────────────────────
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(AppColors.surfaceAltDark),
      elevation: WidgetStateProperty.all(0),
      hintStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 15,
          color: AppColors.textTertiaryDark,
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 15,
          color: AppColors.textPrimaryDark,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: AppRadius.inputRadius),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 18),
      ),
    ),

    // ── Bottom Navigation (Dark) ──────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.navActive,
      unselectedItemColor: AppColors.navInactive,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 26),
      unselectedIconTheme: IconThemeData(size: 24),
      selectedLabelStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ── Navigation Bar (Dark) ─────────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.navBg,
      indicatorColor: AppColors.surfaceAltDark,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.navActive, size: 26);
        }
        return const IconThemeData(color: AppColors.navInactive, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontFamily: AppTypography.bodyFont,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.navActive,
          );
        }
        return const TextStyle(
          fontFamily: AppTypography.bodyFont,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.navInactive,
        );
      }),
      elevation: 0,
      height: 64,
    ),

    // ── Bottom Sheet (Dark) ───────────────────────────────────────────────
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceDark,
      modalBackgroundColor: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      dragHandleColor: Color(0xFF444444),
      dragHandleSize: Size(40, 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      showDragHandle: true,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      titleTextStyle: AppTypography.h3.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textSecondaryDark,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.textPrimaryDark),
        overlayColor: WidgetStateProperty.all(const Color(0x14FFFFFF)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
        minimumSize: WidgetStateProperty.all(const Size(40, 40)),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
        ),
      ),
    ),

    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      minLeadingWidth: 0,
      iconColor: AppColors.textSecondaryDark,
      textColor: AppColors.textPrimaryDark,
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimaryDark,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
      ),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
    ),

    // ── Chips (Dark) ──────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceAltDark,
      selectedColor: AppColors.primaryDarker,
      disabledColor: const Color(0xFF2A2A2A),
      deleteIconColor: AppColors.textSecondaryDark,
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimaryDark,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.chipRadius),
      side: BorderSide.none,
      elevation: 0,
      pressElevation: 0,
      showCheckmark: false,
    ),

    // ── Tab Bar (Dark) ────────────────────────────────────────────────────
    tabBarTheme: TabBarThemeData(
      // Solid primary pill + on-primary label (readable vs red-on-red tint).
      labelColor: AppColors.textOnPrimary,
      unselectedLabelColor: AppColors.textSecondaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: AppTypography.bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      overlayColor: WidgetStateProperty.all(const Color(0x0AFF383C)),
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.heroTitleLight.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      displayMedium: AppTypography.h1.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      displaySmall: AppTypography.h2.copyWith(color: AppColors.textPrimaryDark),
      headlineLarge: AppTypography.h2.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      headlineMedium: AppTypography.h3.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      headlineSmall: AppTypography.h4.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      titleLarge: AppTypography.h3.copyWith(color: AppColors.textPrimaryDark),
      titleMedium: AppTypography.h4.copyWith(color: AppColors.textPrimaryDark),
      titleSmall: AppTypography.labelLarge.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondaryDark,
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: AppColors.textSecondaryDark,
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: AppColors.textTertiaryDark,
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────