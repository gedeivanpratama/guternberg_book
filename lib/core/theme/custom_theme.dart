import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme(this.context);
  final BuildContext context;

  ThemeData get() => ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      );
}
