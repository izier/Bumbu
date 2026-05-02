import 'package:flutter/material.dart';

//  4. BORDER RADIUS
// ─────────────────────────────────────────────────────────────────────────────

class AppRadius {
  AppRadius._();

  static const double xs = 6.0;
  static const double sm = 10.0;
  static const double md = 14.0;
  static const double lg = 18.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 999.0; // pill/circle

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(18));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(10));
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(14),
  );
  static const BorderRadius pillRadius = BorderRadius.all(Radius.circular(999));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(14));
  static const BorderRadius heroImageRadius = BorderRadius.all(
    Radius.circular(24),
  );
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(28),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
