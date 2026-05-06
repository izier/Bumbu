import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});
