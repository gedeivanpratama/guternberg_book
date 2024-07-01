import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guternberg_book/core/global/data/repositories/book_local_repository_imp.dart';
import 'package:guternberg_book/core/db/db_service.dart';
import 'package:guternberg_book/core/utils/flavor_settings.dart';
import 'package:guternberg_book/core/utils/network_info.dart';
import 'package:guternberg_book/features/home/data/datasources/book_remote_datasource.dart';
import 'package:guternberg_book/features/home/data/repositories/book_repository_imp.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';

import '../global/data/datasources/book_local_datasource.dart';
import '../global/domain/repositories/book_local_repository.dart';

class Injection {
  final BuildContext context;
  Injection(this.context);

  get(Flavor flavor) {
    return [
      RepositoryProvider<FlavorSetting>(
        create: (context) => FlavorSetting(flavor),
      ),
      RepositoryProvider<DBService>(
        create: (context) => DBService(),
      ),
      RepositoryProvider<Dio>(
        create: (context) => Dio(),
      ),
      RepositoryProvider<NetworkInfo>(
        create: (context) => NetworkInfo(
          connectivity: Connectivity(),
        ),
      ),
      RepositoryProvider<BookLocalDataSource>(
        create: (context) => BookLocalDataSourceImp(
          db: context.read<DBService>(),
        ),
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
          networkInfo: context.read<NetworkInfo>(),
        ),
      ),
      RepositoryProvider<BookLocalRepository>(
        create: (context) => BookLocalRepositoryImp(
          datasource: context.read<BookLocalDataSource>(),
        ),
      ),
    ];
  }
}
