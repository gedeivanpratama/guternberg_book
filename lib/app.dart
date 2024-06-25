import 'package:flutter/material.dart';
import 'package:guternberg_book/core/theme/custom_theme.dart';
import 'package:guternberg_book/features/home/presentations/screens/home_screen.dart';
import 'package:guternberg_book/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme(context).get(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
