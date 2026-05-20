import 'package:flutter/material.dart';

enum AppThemeVariant {
  light(
    id: 'light',
    label: 'White',
    seedColor: Color(0xFF9E9E9E),
    brightness: Brightness.light,
    monochrome: true,
  ),
  dark(
    id: 'dark',
    label: 'Black',
    seedColor: Color(0xFF757575),
    brightness: Brightness.dark,
    monochrome: true,
  ),
  ocean(
    id: 'ocean',
    label: 'Ocean',
    seedColor: Color(0xFF00B4D8),
    brightness: Brightness.dark,
  ),
  sunset(
    id: 'sunset',
    label: 'Sunset',
    seedColor: Color(0xFFFF6B35),
    brightness: Brightness.dark,
  ),
  forest(
    id: 'forest',
    label: 'Forest',
    seedColor: Color(0xFF2ECC71),
    brightness: Brightness.dark,
  ),
  rose(
    id: 'rose',
    label: 'Rose',
    seedColor: Color(0xFFFF4081),
    brightness: Brightness.dark,
  ),
  amethyst(
    id: 'amethyst',
    label: 'Amethyst',
    seedColor: Color(0xFFAA00FF),
    brightness: Brightness.dark,
  ),
  sky(
    id: 'sky',
    label: 'Sky',
    seedColor: Color(0xFF42A5F5),
    brightness: Brightness.light,
  );

  const AppThemeVariant({
    required this.id,
    required this.label,
    required this.seedColor,
    required this.brightness,
    this.monochrome = false,
  });

  final String id;
  final String label;
  final Color seedColor;
  final Brightness brightness;
  final bool monochrome;

  bool get isDark => brightness == Brightness.dark;

  static AppThemeVariant fromId(String id) {
    return AppThemeVariant.values.firstWhere(
      (variant) => variant.id == id,
      orElse: () => AppThemeVariant.dark,
    );
  }
}
