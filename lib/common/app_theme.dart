import 'package:flutter/material.dart';

class AppColors {
  static const Color LightGold = Color(0xffC49A6C);
  static const Color Gold = Color(0xffC89755);
  static const Color Secondary1 = Color(0xff545154);
  static const Color LightSilver = Color(0xff5F6062);
  static const Color LightBlue = Color(0xff6C96C4);
  static const Color LightGreen = Color(0xffC2C46C);
  static const Color Green = Color(0xff6CC49A);
  static const Color Purple = Color(0xff9A6CC4);
  static const Color LightRed = Color(0xffC46E6C);
  static const Color White = Color(0xffffffff);
  static const Color BackgroundBox = Color.fromARGB(41, 158, 158, 158);

}

ThemeData AppTheme() {
  return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarHeight: 44.0,
        centerTitle: true,
        backgroundColor: AppColors.LightGold,
        foregroundColor: AppColors.White,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.LightSilver,
      dialogBackgroundColor: AppColors.LightSilver,
      backgroundColor: AppColors.LightSilver,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.LightGold),
        ),
      ),
      focusColor: AppColors.LightGold,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColors.LightGold),
        focusColor: AppColors.LightGold,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.LightGold)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.Secondary1)),
      ),
    dividerColor: AppColors.Secondary1,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.LightGold, circularTrackColor: AppColors.Gold, linearTrackColor: AppColors.Gold),


  );
}

class AppBoxDecoration {
  BoxDecoration all ({color = AppColors.BackgroundBox, borderRadius = 10.0, borderWidth = 0.4 }) {
    return BoxDecoration(
        border: Border.all(color: AppColors.Secondary1, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
    color: color);
  }
}
