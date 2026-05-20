import 'package:flutter/material.dart';

import 'app_theme_variant.dart';

class AppTheme {
  static ThemeData fromVariant(AppThemeVariant variant) {
    final palette = _palette(variant);
    final colorScheme = variant.monochrome
        ? _monochromeScheme(variant, palette.scaffold)
        : ColorScheme.fromSeed(
            seedColor: variant.seedColor,
            brightness: variant.brightness,
            surface: palette.scaffold,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: variant.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.scaffold,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.scaffold,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      extensions: [AppThemeExtension(variant: variant, palette: palette)],
    );
  }

  static ThemePalette _palette(AppThemeVariant variant) {
    if (variant.monochrome) {
      return _monochromePalette(variant);
    }

    final scaffold = _tintedBase(variant, lightness: 0.0);
    final board = _tintedBase(variant, lightness: 0.06);
    final grid = _tintedBase(variant, lightness: 0.12);

    return ThemePalette(
      scaffold: scaffold,
      board: board,
      grid: grid,
    );
  }

  /// Pure white / pure black themes without color tint.
  static ThemePalette _monochromePalette(AppThemeVariant variant) {
    if (variant == AppThemeVariant.light) {
      return const ThemePalette(
        scaffold: Color(0xFFFFFFFF),
        board: Color(0xFFF5F5F5),
        grid: Color(0xFFE8E8E8),
      );
    }

    return const ThemePalette(
      scaffold: Color(0xFF000000),
      board: Color(0xFF141414),
      grid: Color(0xFF242424),
    );
  }

  static ColorScheme _monochromeScheme(
    AppThemeVariant variant,
    Color surface,
  ) {
    if (variant == AppThemeVariant.light) {
      return const ColorScheme.light(
        primary: Color(0xFF212121),
        onPrimary: Colors.white,
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF212121),
        surfaceContainerHighest: Color(0xFFEEEEEE),
      );
    }

    return const ColorScheme.dark(
      primary: Color(0xFFE0E0E0),
      onPrimary: Color(0xFF000000),
      surface: Color(0xFF000000),
      onSurface: Color(0xFFF5F5F5),
      surfaceContainerHighest: Color(0xFF1E1E1E),
    );
  }

  /// Builds a background by tinting a dark/light base with the theme seed color.
  static Color _tintedBase(AppThemeVariant variant, {required double lightness}) {
    final base = variant.isDark
        ? const Color(0xFF0B0C10)
        : const Color(0xFFF0F2F8);

    final tinted = Color.alphaBlend(
      variant.seedColor.withValues(alpha: variant.isDark ? 0.28 : 0.14),
      base,
    );

    if (lightness <= 0) return tinted;

    return Color.alphaBlend(
      (variant.isDark ? Colors.white : Colors.black)
          .withValues(alpha: lightness),
      tinted,
    );
  }

  static Color boardBackground(BuildContext context) {
    return Theme.of(context).extension<AppThemeExtension>()?.palette.board ??
        _palette(AppThemeVariant.dark).board;
  }

  static Color boardGrid(BuildContext context) {
    return Theme.of(context).extension<AppThemeExtension>()?.palette.grid ??
        _palette(AppThemeVariant.dark).grid;
  }
}

class ThemePalette {
  const ThemePalette({
    required this.scaffold,
    required this.board,
    required this.grid,
  });

  final Color scaffold;
  final Color board;
  final Color grid;
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.variant,
    required this.palette,
  });

  final AppThemeVariant variant;
  final ThemePalette palette;

  @override
  AppThemeExtension copyWith({
    AppThemeVariant? variant,
    ThemePalette? palette,
  }) {
    return AppThemeExtension(
      variant: variant ?? this.variant,
      palette: palette ?? this.palette,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    return other ?? this;
  }
}
