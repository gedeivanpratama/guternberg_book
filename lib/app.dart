import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guternberg_book/core/theme/custom_theme.dart';
import 'package:guternberg_book/core/utils/flavor_settings.dart';
import 'package:guternberg_book/core/utils/injection.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';
import 'package:guternberg_book/features/home/main_screen.dart';
import 'package:guternberg_book/l10n/l10n.dart';

import 'features/home/presentations/state/book_bloc/book_bloc.dart';

class App extends StatelessWidget {
  final Flavor flavor;
  const App({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: Injection(context).get(flavor),
      child: BlocProvider(
        create: (context) => BookBloc(
          repository: context.read<BookRepository>(),
        ),
        child: MaterialApp(
          theme: CustomTheme(context).get(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
