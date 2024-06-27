import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guternberg_book/core/utils/flavor_settings.dart';
import 'package:guternberg_book/features/home/data/datasources/book_remote_datasource.dart';
import 'package:guternberg_book/features/home/data/repositories/book_repository_imp.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';

class Injection {
  final BuildContext context;
  Injection(this.context);

  get(Flavor flavor) {
    return [
      RepositoryProvider<FlavorSetting>(
        create: (context) => FlavorSetting(flavor),
      ),
      RepositoryProvider<Dio>(
        create: (context) => Dio(),
      ),
      RepositoryProvider<BookRemoteDatasource>(
        create: (context) => BookRemoteDatasourceImp(
          flavorSetting: context.read<FlavorSetting>(),
          dio: context.read<Dio>(),
        ),
      ),
      RepositoryProvider<BookRepository>(
        create: (context) => BookRepositoryImp(
          datasource: context.read<BookRemoteDatasource>(),
        ),
      ),
    ];
  }
}
