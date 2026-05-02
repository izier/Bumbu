import 'package:flutter/material.dart';

//  5. SHADOWS & ELEVATION
// ─────────────────────────────────────────────────────────────────────────────

class AppShadows {
  AppShadows._();

  // Subtle card lift
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 16,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(color: Color(0x07000000), blurRadius: 4, offset: Offset(0, 1)),
  ];

  // Floating action / CTA buttons
  static const List<BoxShadow> ctaButton = [
    BoxShadow(
      color: Color(0x50FF383C),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  // Bottom nav bar
  static const List<BoxShadow> navBar = [
    BoxShadow(color: Color(0x28000000), blurRadius: 24, offset: Offset(0, -4)),
  ];

  // Modal / sheet
  static const List<BoxShadow> modal = [
    BoxShadow(color: Color(0x40000000), blurRadius: 40, offset: Offset(0, -8)),
  ];

  // Input focus
  static const List<BoxShadow> inputFocus = [
    BoxShadow(color: Color(0x30FF383C), blurRadius: 0, spreadRadius: 2),
  ];

  // Image card overlay depth
  static const List<BoxShadow> imageCard = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
