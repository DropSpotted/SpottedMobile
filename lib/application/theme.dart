import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotted/application/colorful.dart';

abstract class Palette {
  late Brightness brightness;
  late Color whiteColor;
  late Color inactiveColor;
  late Color borderColor;
  late Color cardColor;
  late Color primaryColor;
  late Color accentColor;
  late Color errorColor;
  late Color iconColor;
  late Color scaffoldBackgroundColor;
  late Color appBarBackgroundColor;
  late Color textOnPrimaryColor;
  late Color textBodyColor;
  late Color textDisplayColor;
  late Color primaryTextDisplayColor;
  late Color primaryTextBodyColor;
}

class LightPalette extends Palette {
  @override
  final Brightness brightness = Brightness.light;
  @override
  final Color whiteColor = Colors.white;
  @override
  final Color inactiveColor = Colors.grey[100]!;
  @override
  final Color borderColor = Colors.grey[400]!;
  @override
  final Color cardColor = const Color(0xffffffff);
  @override
  final Color primaryColor = const Color(0xff87909C);
  @override
  final Color accentColor = const Color(0xff199049);
  @override
  final Color errorColor = const Color(0xffECA090);
  @override
  final Color iconColor = const Color(0xff221D35);
  @override
  final Color scaffoldBackgroundColor = Colorful.wildSand;
  @override
  final Color textOnPrimaryColor = Colors.white70;
  @override
  final Color textBodyColor = Colors.black54;
  @override
  final Color textDisplayColor = Colors.grey[400]!;
  @override
  final Color primaryTextBodyColor = Colors.black;
  @override
  final Color primaryTextDisplayColor = Colors.black;
  @override
  final Color appBarBackgroundColor = Colors.transparent;
}

class DarkPalette extends Palette {
  @override
  final Brightness brightness = Brightness.dark;
  @override
  final Color whiteColor = Colors.white;
  @override
  final Color inactiveColor = const Color(0xff191B26);
  @override
  final Color borderColor = const Color(0xff191B26);
  @override
  final Color cardColor = const Color(0xff282938);
  @override
  final Color primaryColor = const Color(0xff191B26);
  @override
  final Color accentColor = const Color(0xff269900);
  @override
  final Color errorColor = const Color(0xffECA090);
  @override
  final Color iconColor = const Color(0xff87a67d);
  @override
  final Color scaffoldBackgroundColor = const Color(0xff191B26);
  @override
  final Color textOnPrimaryColor = Colors.white70;
  @override
  final Color textBodyColor = Colors.white70;
  @override
  final Color textDisplayColor = Colors.white70;
  @override
  final Color primaryTextBodyColor = Colors.white70;
  @override
  final Color primaryTextDisplayColor = Colors.white70;
  @override
  final Color appBarBackgroundColor = Colors.grey.shade900;
}

class ProjectColors {
  static const List<Color> purpleToBlue = [
    Color(0xffD96FF8),
    Color(0xff1A50FF),
  ];

  static const Color gray2 = Color(0xff1D1929);
  static const Color gray8 = Color(0xffA5A3A9);
}

class AppTheme {
  ThemeData theme(Palette palette) {
    final theme = ThemeData(
      brightness: palette.brightness,
      primarySwatch: generateMaterialColor(palette.primaryColor),
      accentColor: palette.accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryTextTheme: _textThemeHandset.apply(
        bodyColor: palette.primaryTextBodyColor,
        displayColor: palette.primaryTextDisplayColor,
      ),
      textTheme: _textThemeHandset.apply(
        bodyColor: palette.primaryTextBodyColor,
        displayColor: palette.primaryTextDisplayColor,
      ),
      canvasColor: palette.scaffoldBackgroundColor,
      backgroundColor: palette.scaffoldBackgroundColor,
      scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
    );
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        brightness: palette.brightness,
        elevation: 0,
        color: palette.appBarBackgroundColor,
        iconTheme: const IconThemeData(),
        actionsIconTheme: const IconThemeData(),
        textTheme: _textThemeHandset,
      ),
      cardColor: palette.cardColor,
      colorScheme: theme.colorScheme.copyWith(
        error: palette.errorColor,
        background: palette.scaffoldBackgroundColor,
        surface: palette.scaffoldBackgroundColor,
      ),
      iconTheme: IconThemeData(
        color: palette.iconColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: theme.accentColor,
        selectedIconTheme: const IconThemeData(),
        unselectedIconTheme: const IconThemeData(),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xff93cb80),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Color(0xff93cb80)),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: _textThemeHandset.caption?.copyWith(
          color: Colorful.flamingo,
        ),
      ),
    );
  }

  TextTheme get _textThemeHandset => TextTheme(
        headline1: GoogleFonts.nunitoSans(
          fontSize: 96,
          fontWeight: FontWeight.w700,
        ),
        headline2: GoogleFonts.nunitoSans(
          fontSize: 60,
          fontWeight: FontWeight.w700,
        ),
        headline3: GoogleFonts.nunitoSans(
          fontSize: 48,
          fontWeight: FontWeight.w700,
        ),
        headline4: GoogleFonts.nunitoSans(
          fontSize: 34,
          fontWeight: FontWeight.w800,
        ),
        headline5: GoogleFonts.nunitoSans(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        headline6: GoogleFonts.nunitoSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        subtitle1: GoogleFonts.nunitoSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        subtitle2: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: GoogleFonts.nunitoSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyText2: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        button: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        //caption
        caption: GoogleFonts.nunitoSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
        ),
        overline: GoogleFonts.nunitoSans(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      );

  MaterialColor generateMaterialColor(Color color) => MaterialColor(color.value, {
        50: tintColor(color, 0.9),
        100: tintColor(color, 0.8),
        200: tintColor(color, 0.6),
        300: tintColor(color, 0.4),
        400: tintColor(color, 0.2),
        500: color,
        600: shadeColor(color, 0.1),
        700: shadeColor(color, 0.2),
        800: shadeColor(color, 0.3),
        900: shadeColor(color, 0.4),
      });

  int tintValue(int value, double factor) => max(
        0,
        min((value + ((255 - value) * factor)).round(), 255),
      );

  Color tintColor(Color color, double factor) => Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1,
      );

  int shadeValue(int value, double factor) => max(
        0,
        min(value - (value * factor).round(), 255),
      );

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );
}

extension ThemeDatas on BuildContext {
  ThemeData get themeData => Theme.of(this);
}

extension TextThemes on BuildContext {
  TextTheme get textThemes => themeData.textTheme;
}

extension AppBarThemes on BuildContext {
  AppBarTheme get appBarThemes => themeData.appBarTheme;
}

extension ColorShemas on BuildContext {
  ColorScheme get colors => themeData.colorScheme;
}

extension TextThemesExtension on TextTheme {
  TextStyle get title1 => GoogleFonts.nunitoSans(
        fontSize: 60,
        fontWeight: FontWeight.w700,
        height: 72 / 60,
      );

  TextStyle get title2 => GoogleFonts.nunitoSans(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 56 / 48,
      );

  TextStyle get title3 => GoogleFonts.nunitoSans(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        height: 40 / 34,
      );

  TextStyle get hheadline => GoogleFonts.nunitoSans(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 32 / 24,
      );

  TextStyle get subheadline => GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 32 / 18,
      );

  TextStyle get body => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      );

  TextStyle get bodySmall => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 24 / 14,
      );

  TextStyle get bodyBold => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      );

  TextStyle get bodySmallBold => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 24 / 14,
      );

  TextStyle get buttonMedium => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 16 / 14,
      );
  TextStyle get buttonLarge => GoogleFonts.nunitoSans(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w600,
      );

  TextStyle get buttonSmall => GoogleFonts.nunitoSans(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.bold,
      );
}
