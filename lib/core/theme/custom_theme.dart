import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme(this.context);
  final BuildContext context;

  ThemeData get() => ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF436850),
          titleTextStyle: TextStyle(color: Color.fromRGBO(236, 244, 214, 1)),
        ),
        primaryColor: Color(0xFF2D9596),
        // scaffoldBackgroundColor: Color(0xFFECF4D6),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: Color(0xffFBFADA),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(
              Color(0xffFBFADA),
            ),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Color(0xffFBFADA),
          ),
          displayMedium: TextStyle(
            color: Color(0xffFBFADA),
          ),
          displaySmall: TextStyle(
            color: Color(0xffFBFADA),
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: Color(0xFF436850),
            fontWeight: FontWeight.bold,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Color(0xFF436850),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF436850),
        ),
        chipTheme: ChipThemeData(
          labelStyle: TextStyle(color: Color(0xffFBFADA)),
          backgroundColor: Color(0xFF436850),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
}
