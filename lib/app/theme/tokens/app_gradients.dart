import 'package:flutter/material.dart';

//  6. GRADIENTS
// ─────────────────────────────────────────────────────────────────────────────

class AppGradients {
  AppGradients._();

  // Hero card overlay — food image darkening
  static const LinearGradient heroOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xCC000000)],
    stops: [0.35, 1.0],
  );

  // Hero overlay — top & bottom (for text on both edges)
  static const LinearGradient heroOverlayDouble = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x80000000), Color(0x00000000), Color(0xCC000000)],
    stops: [0.0, 0.4, 1.0],
  );

  // Primary brand gradient (CTA buttons, banners)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFF383C), Color(0xFFFF6840)],
  );

  // Warm amber gradient (promo banners)
  static const LinearGradient amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF8C00), Color(0xFFFFB84D)],
  );

  // Background shimmer
  static const LinearGradient shimmer = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFEDECE9), Color(0xFFF8F7F5), Color(0xFFEDECE9)],
    stops: [0.0, 0.5, 1.0],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
