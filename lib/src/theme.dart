import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme = const TextTheme();

  const MaterialTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF007AFF),
      surfaceTint: Color(0xFF007AFF),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd8e2ff),
      onPrimaryContainer: Color(0xff001a41),
      secondary: Color(0xff565e71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdbe2f9),
      onSecondaryContainer: Color(0xff141b2c),
      tertiary: Color(0xFF007AFF),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd8e2ff),
      onTertiaryContainer: Color(0xff001a41),
      error: Color(0xFFF5222D),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff3b0908),
      background: Colors.white,
      onBackground: Color(0xFF333333),
      surface: Color(0xFFF5F6F8),
      onSurface: Color(0xFF333333),
      surfaceVariant: Color(0xffe1e2ec),
      onSurfaceVariant: Color(0xff44474f),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inverseOnSurface: Color(0xfff0f0f7),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff141b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff001a41),
      tertiaryFixedDim: Color(0xffadc6ff),
      onTertiaryFixedVariant: Color(0xff2b4678),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xFFF5F6F8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff102f60),
      primaryContainer: Color(0xff2b4678),
      onPrimaryContainer: Color(0xffd8e2ff),
      secondary: Color(0xffbfc6dc),
      onSecondary: Color(0xff293041),
      secondaryContainer: Color(0xff3f4759),
      onSecondaryContainer: Color(0xffdbe2f9),
      tertiary: Color(0xffadc6ff),
      onTertiary: Color(0xff102f60),
      tertiaryContainer: Color(0xff2b4678),
      onTertiaryContainer: Color(0xffd8e2ff),
      error: Color(0xffffb3ad),
      onError: Color(0xff571e1b),
      errorContainer: Color(0xff73332f),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff2f3036),
      onBackground: Color(0xffe2e2e9),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      surfaceVariant: Color(0xff44474f),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inverseOnSurface: Color(0xff2f3036),
      inversePrimary: Color(0xFF007AFF),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff141b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff001a41),
      tertiaryFixedDim: Color(0xffadc6ff),
      onTertiaryFixedVariant: Color(0xff2b4678),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xFF333333),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
      );

  /// green
  static const green = ExtendedColor(
    seed: Color(0xff22ba67),
    value: Color(0xff22ba67),
    light: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff00210d),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff00210d),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff00210d),
    ),
    dark: ColorFamily(
      color: Color(0xff97d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff97d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff97d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
  );

  /// warning
  static const warning = ExtendedColor(
    seed: Color(0xfff3a440),
    value: Color(0xfff3a440),
    light: ColorFamily(
      color: Color(0xff835415),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddba),
      onColorContainer: Color(0xff2b1700),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff835415),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddba),
      onColorContainer: Color(0xff2b1700),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff835415),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddba),
      onColorContainer: Color(0xff2b1700),
    ),
    dark: ColorFamily(
      color: Color(0xfffaba72),
      onColor: Color(0xff482900),
      colorContainer: Color(0xff673d00),
      onColorContainer: Color(0xffffddba),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfffaba72),
      onColor: Color(0xff482900),
      colorContainer: Color(0xff673d00),
      onColorContainer: Color(0xffffddba),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfffaba72),
      onColor: Color(0xff482900),
      colorContainer: Color(0xff673d00),
      onColorContainer: Color(0xffffddba),
    ),
  );
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextStyle get labelSmall => theme.textTheme.labelSmall!;
  TextStyle get labelMedium => theme.textTheme.labelMedium!;
  TextStyle get labelLarge => theme.textTheme.labelLarge!;

  TextStyle get titleSmall => theme.textTheme.titleSmall!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;

  TextStyle get bodySmall => theme.textTheme.bodySmall!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;

  Color get backgroundColor => theme.colorScheme.surface;
  Color get onBackgroundColor => theme.colorScheme.onSurface;

  Color get primaryColor => theme.colorScheme.primary;
  Color get onPrimaryColor => theme.colorScheme.onPrimary;
  Color get primaryContainerColor => theme.colorScheme.primaryContainer;
  Color get onPrimaryContainerColor => theme.colorScheme.onPrimaryContainer;

  Color get secondaryColor => theme.colorScheme.secondary;
  Color get onSecondaryColor => theme.colorScheme.onSecondary;
  Color get secondaryContainerColor => theme.colorScheme.secondaryContainer;
  Color get onSecondaryContainerColor => theme.colorScheme.onSecondaryContainer;

  Color get tertiaryColor => theme.colorScheme.tertiary;
  Color get onTertiaryColor => theme.colorScheme.onTertiary;
  Color get tertiaryContainerColor => theme.colorScheme.tertiaryContainer;
  Color get onTertiaryContainerColor => theme.colorScheme.onTertiaryContainer;

  Color get surfaceColor => theme.colorScheme.surface;
  Color get onSurfaceColor => theme.colorScheme.onSurface;
  Color get surfaceVariantColor => theme.colorScheme.surfaceContainerHighest;
  Color get onSurfaceVariantColor => theme.colorScheme.onSurfaceVariant;

  Color get outlineColor => theme.colorScheme.outline;
  Color get outlineVariantColor => theme.colorScheme.outlineVariant;
  Color get shadowColor => theme.colorScheme.shadow;

  Color get dividerColor => theme.dividerColor;
  Color get errorColor => theme.colorScheme.error;
}
