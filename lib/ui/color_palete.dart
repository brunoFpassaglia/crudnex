import 'package:flutter/material.dart';

final ThemeData darkThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: DarkThemeColors.marineblue,
  primaryColor: DarkThemeColors.marineblue[500],
  accentColor: DarkThemeColors.accentamber,
  iconTheme: IconThemeData(color: DarkThemeColors.lightergrey[100]),
  scaffoldBackgroundColor: DarkThemeColors.lightergrey[50],
  errorColor: DarkThemeColors.dangerred,
  cardColor: DarkThemeColors.lightergrey[100],
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: DarkThemeColors.lightergrey[600],
    labelColor: DarkThemeColors.marineblue,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.0, color: DarkThemeColors.accentamber),
      ),
    ),
  ),
  dividerColor: DarkThemeColors.accentamber,
);

class DarkThemeColors {
  DarkThemeColors._();
  static const MaterialColor darkgrey =
      MaterialColor(_darkgreyPrimaryValue, <int, Color>{
    50: Color(0xFFE6E7E8),
    100: Color(0xFFC1C3C6),
    200: Color(0xFF979BA0),
    300: Color(0xFF6D7279),
    400: Color(0xFF4E545D),
    500: Color(_darkgreyPrimaryValue),
    600: Color(0xFF2A303A),
    700: Color(0xFF232932),
    800: Color(0xFF1D222A),
    900: Color(0xFF12161C),
  });
  static const int _darkgreyPrimaryValue = 0xFF2F3640;

  static const MaterialColor darkgreyAccent =
      MaterialColor(_darkgreyAccentValue, <int, Color>{
    100: Color(0xFF619CFF),
    200: Color(_darkgreyAccentValue),
    400: Color(0xFF005EFA),
    700: Color(0xFF0054E0),
  });
  static const int _darkgreyAccentValue = 0xFF2E7CFF;

  static const MaterialColor lightergrey =
      MaterialColor(_lightergreyPrimaryValue, <int, Color>{
    50: Color(0xFFF0F2F4),
    100: Color(0xFFD9DDE4),
    200: Color(0xFFBFC7D3),
    300: Color(0xFFA5B1C1),
    400: Color(0xFF92A0B3),
    500: Color(_lightergreyPrimaryValue),
    600: Color(0xFF77879E),
    700: Color(0xFF6C7C95),
    800: Color(0xFF62728B),
    900: Color(0xFF4F607B),
  });
  static const int _lightergreyPrimaryValue = 0xFF7F8FA6;

  static const MaterialColor lightergreyAccent =
      MaterialColor(_lightergreyAccentValue, <int, Color>{
    100: Color(0xFFDEEAFF),
    200: Color(_lightergreyAccentValue),
    400: Color(0xFF78ABFF),
    700: Color(0xFF5E9BFF),
  });
  static const int _lightergreyAccentValue = 0xFFABCBFF;

  static const MaterialColor accentamber =
      MaterialColor(_accentamberPrimaryValue, <int, Color>{
    50: Color(0xFFFFF0E0),
    100: Color(0xFFFEDAB3),
    200: Color(0xFFFDC280),
    300: Color(0xFFFCAA4D),
    400: Color(0xFFFC9726),
    500: Color(_accentamberPrimaryValue),
    600: Color(0xFFFA7D00),
    700: Color(0xFFFA7200),
    800: Color(0xFFF96800),
    900: Color(0xFFF85500),
  });
  static const int _accentamberPrimaryValue = 0xFFFB8500;

  static const MaterialColor accentamberAccent =
      MaterialColor(_accentamberAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_accentamberAccentValue),
    400: Color(0xFFFFCCB8),
    700: Color(0xFFFFBA9F),
  });
  static const int _accentamberAccentValue = 0xFFFFF1EB;

  static const MaterialColor marineblue =
      MaterialColor(_marinebluePrimaryValue, <int, Color>{
    50: Color(0xFF67A2D9),
    100: Color(0xFF317CC3),
    200: Color(0xFF265F96),
    300: Color(0xFF173B5D),
    400: Color(0xFF112C44),
    500: Color(_marinebluePrimaryValue),
    600: Color(0xFF050C14),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });
  static const int _marinebluePrimaryValue = 0xFF0B1C2C;

  static const MaterialColor marineblueAccent =
      MaterialColor(_marineblueAccentValue, <int, Color>{
    100: Color(0xFF419EF5),
    200: Color(_marineblueAccentValue),
    400: Color(0xFF0D365D),
    700: Color(0xFF0E2942),
  });
  static const int _marineblueAccentValue = 0xFF0A6BC6;

  static const MaterialColor brighteramber =
      MaterialColor(_brighteramberPrimaryValue, <int, Color>{
    50: Color(0xFFFFF6E1),
    100: Color(0xFFFFE9B3),
    200: Color(0xFFFFDB81),
    300: Color(0xFFFFCD4F),
    400: Color(0xFFFFC229),
    500: Color(_brighteramberPrimaryValue),
    600: Color(0xFFFFB003),
    700: Color(0xFFFFA702),
    800: Color(0xFFFF9F02),
    900: Color(0xFFFF9001),
  });
  static const int _brighteramberPrimaryValue = 0xFFFFB703;

  static const MaterialColor brighteramberAccent =
      MaterialColor(_brighteramberAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_brighteramberAccentValue),
    400: Color(0xFFFFE0BF),
    700: Color(0xFFFFD4A6),
  });
  static const int _brighteramberAccentValue = 0xFFFFF9F2;

  static const MaterialColor dangerred =
      MaterialColor(_dangerredPrimaryValue, <int, Color>{
    50: Color(0xFFFBE0E0),
    100: Color(0xFFF5B3B3),
    200: Color(0xFFEE8080),
    300: Color(0xFFE74D4D),
    400: Color(0xFFE22626),
    500: Color(_dangerredPrimaryValue),
    600: Color(0xFFD90000),
    700: Color(0xFFD40000),
    800: Color(0xFFCF0000),
    900: Color(0xFFC70000),
  });
  static const int _dangerredPrimaryValue = 0xFFDD0000;

  static const MaterialColor dangerredAccent =
      MaterialColor(_dangerredAccentValue, <int, Color>{
    100: Color(0xFFFFEFEF),
    200: Color(_dangerredAccentValue),
    400: Color(0xFFFF8989),
    700: Color(0xFFFF6F6F),
  });
  static const int _dangerredAccentValue = 0xFFFFBCBC;

  static const MaterialColor confirmationgreen =
      MaterialColor(_confirmationgreenPrimaryValue, <int, Color>{
    50: Color(0xFFF0FCF3),
    100: Color(0xFFD8F7E2),
    200: Color(0xFFBFF2CE),
    300: Color(0xFFA5ECBA),
    400: Color(0xFF91E8AC),
    500: Color(_confirmationgreenPrimaryValue),
    600: Color(0xFF76E195),
    700: Color(0xFF6BDD8B),
    800: Color(0xFF61D981),
    900: Color(0xFF4ED16F),
  });
  static const int _confirmationgreenPrimaryValue = 0xFF7EE49D;

  static const MaterialColor confirmationgreenAccent =
      MaterialColor(_confirmationgreenAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_confirmationgreenAccentValue),
    400: Color(0xFFC8FFD5),
    700: Color(0xFFAEFFC2),
  });
  static const int _confirmationgreenAccentValue = 0xFFFBFFFC;

  static const MaterialColor darkconfirmationgreen =
      MaterialColor(_darkconfirmationgreenPrimaryValue, <int, Color>{
    50: Color(0xFFE5EAE8),
    100: Color(0xFFBFCBC5),
    200: Color(0xFF95A89E),
    300: Color(0xFF6A8577),
    400: Color(0xFF4A6A59),
    500: Color(_darkconfirmationgreenPrimaryValue),
    600: Color(0xFF254936),
    700: Color(0xFF1F402E),
    800: Color(0xFF193727),
    900: Color(0xFF0F271A),
  });
  static const int _darkconfirmationgreenPrimaryValue = 0xFF2A503C;

  static const MaterialColor darkconfirmationgreenAccent =
      MaterialColor(_darkconfirmationgreenAccentValue, <int, Color>{
    100: Color(0xFF67FFA7),
    200: Color(_darkconfirmationgreenAccentValue),
    400: Color(0xFF01FF6C),
    700: Color(0xFF00E661),
  });
  static const int _darkconfirmationgreenAccentValue = 0xFF34FF89;
}
