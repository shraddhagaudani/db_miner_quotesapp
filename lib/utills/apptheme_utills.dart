import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

 static ThemeData lighttheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: CupertinoColors.systemOrange,
    ),
  );

 static ThemeData darktheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: CupertinoColors.systemTeal,
    ),
  );
}
