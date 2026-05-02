import 'package:flutter/material.dart';

//  7. ANIMATIONS
//     Centralized durations, curves, and reusable animated widgets.
//     Strategy: snappy base (180–220 ms) + subtle spring for micro-interactions.
// ─────────────────────────────────────────────────────────────────────────────

class AppAnimations {
  AppAnimations._();

  // ── Durations ─────────────────────────────────────────────────────────────
  /// Instant feedback — icon color swap, ripple start            (micro)
  static const Duration micro = Duration(milliseconds: 120);

  /// Button press, chip select, switch toggle                    (snappy base)
  static const Duration fast = Duration(milliseconds: 180);

  /// Nav indicator slide, card lift, input border               (snappy base)
  static const Duration base = Duration(milliseconds: 200);

  /// Bottom sheet, dialog entrance, page hero                   (smooth)
  static const Duration medium = Duration(milliseconds: 280);

  /// Route transitions, theme switch                            (smooth)
  static const Duration slow = Duration(milliseconds: 350);

  /// Skeleton shimmer cycle                                      (ambient)
  static const Duration shimmer = Duration(milliseconds: 1400);

  // ── Curves ────────────────────────────────────────────────────────────────
  /// Standard ease — most UI state changes
  static const Curve standard = Curves.easeInOut;

  /// Entrance — elements appearing on screen
  static const Curve enter = Curves.easeOut;

  /// Exit — elements leaving screen
  static const Curve exit = Curves.easeIn;

  /// Spring — micro-interactions (icon scale, button press)
  static const Curve spring = Curves.elasticOut;

  /// Decelerate — bottom sheet / modal slide-up
  static const Curve decelerate = Curves.decelerate;

  /// Emphasised — Material 3 expressive nav indicator
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
}

// ─────────────────────────────────────────────────────────────────────────────
