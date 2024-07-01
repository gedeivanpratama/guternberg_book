import 'package:guternberg_book/core/global/data/datasources/book_local_datasource.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';

import 'package:guternberg_book/features/home/data/models/book_response.dart';

import '../../domain/repositories/book_local_repository.dart';

class BookLocalRepositoryImp implements BookLocalRepository {
  final BookLocalDataSource datasource;

  BookLocalRepositoryImp({required this.datasource});

  @override
  Future<Result<bool, Exception>> disLikeBook(Book params) async {
    try {
      final result = await datasource.disLikeBook(params);
      return Success(result);
    } catch (e) {
      return Failure(
        CustomError(message: "something when wrong !"),
      );
    }
  }

  @override
  Future<Result<List<Book>, Exception>> getBooks() async {
    try {
      final result = await datasource.getBooks();
      return Success(result);
    } catch (e) {
      return Failure(
        CustomError(message: "something when wrong !"),
      );
    }
  }

  @override
  Future<Result<bool, Exception>> likeBook(Book params) async {
    try {
      final result = await datasource.likeBook(params);
      return Success(result);
    } catch (e) {
      return Failure(
        CustomError(message: "something when wrong !"),
      );
    }
  }
}
