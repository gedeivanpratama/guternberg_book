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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF436850),
              foregroundColor: Colors.white),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(
            Color(0xFF436850),
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Color(0xFF436850),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.all(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xFF436850),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xFF436850),
              ),
            ),
          ),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF436850),
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xffFBFADA),
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
