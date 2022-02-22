import 'package:flutter/material.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';

class AppTheme {
  AppTheme();

  static ThemeData? theme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    primaryColor: AppColor.primary,
    colorScheme:
        ThemeData().colorScheme.copyWith(secondary: AppColor.secondary),
    cardColor: AppColor.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: AppColor.primary,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: AppColor.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(style: BorderStyle.solid, color: AppColor.secondary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
            const BorderSide(style: BorderStyle.solid, color: AppColor.primary),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 4,
      color: AppColor.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return AppColor.secondary;
            }
          },
        ),
        splashFactory: InkSplash.splashFactory,
        backgroundColor: MaterialStateProperty.all(AppColor.primary),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.white),
    focusColor: AppColor.secondary,
    splashColor: AppColor.secondary,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColor.primary, width: 2.5),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
    dividerColor: AppColor.secondary,
  );
}
