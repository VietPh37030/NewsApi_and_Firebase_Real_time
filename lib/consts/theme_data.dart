import 'package:flutter/material.dart';
import 'global_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
      isDarkTheme ? darkScaffoldColor : lightScaffoldColor,
      primaryColor: isDarkTheme ? darkCardColor : lightCardColor,
      hintColor: isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade700,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: isDarkTheme ? Colors.white : Colors.black,
        selectionColor: Colors.blue,
      ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: isDarkTheme ? Colors.white : Colors.black,
        displayColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      cardColor: isDarkTheme ? darkCardColor : lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: ThemeData().colorScheme.copyWith(
        primary: isDarkTheme ? darkCardColor : lightCardColor,
        secondary: isDarkTheme ? darkIconsColor : lightIconsColor,
        background: isDarkTheme ? darkBackgroundColor : lightBackgroundColor,
        surface: isDarkTheme ? darkBackgroundColor : lightBackgroundColor,
        onPrimary: isDarkTheme ? Colors.white : Colors.black,
        onSecondary: isDarkTheme ? Colors.white : Colors.black,
        onBackground: isDarkTheme ? Colors.white : Colors.black,
        onSurface: isDarkTheme ? Colors.white : Colors.black,
        error: Colors.red,
        onError: Colors.white,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
