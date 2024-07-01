import 'dart:io';

import 'package:dio/dio.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/utils/network_info.dart';
import 'package:guternberg_book/features/home/data/datasources/book_remote_datasource.dart';

import '../models/book_response.dart';
import '../../domain/params/params_book.dart';
import '../../domain/repositories/book_repository.dart';
import '../../../../core/errors/errors_handling.dart';

class BookRepositoryImp implements BookRepository {
  final BookRemoteDatasource datasource;
  final NetworkInfo networkInfo;

  BookRepositoryImp({
    required this.datasource,
    required this.networkInfo,
  });

  @override
  Future<Result<BookResponse, Exception>> getBooks(BookParams params) async {
    if (await networkInfo.isNotConnected()) {
      return Failure(
        CustomError(message: "Your Device Not Conected To Internet"),
      );
    }
    try {
      final result = await datasource.getBooks(params);
      return Success(result);
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode ?? 500;
      return switch (statusCode) {
        HttpStatus.badRequest => Failure(CustomError(message: "Bad request")),
        HttpStatus.notFound => Failure(CustomError(message: "Data Not Found")),
        HttpStatus.requestTimeout => Failure(
            CustomError(message: "Bad Internet connection"),
          ),
        _ => Failure(CustomError(message: "Server Error")),
      };
    } catch (error) {
      return Failure(
        CustomError(message: "something when wrong !"),
      );
    }
  }

  @override
  Future<Result<Book, Exception>> getBook(int bookId) async {
    if (await networkInfo.isNotConnected()) {
      return Failure(
        CustomError(message: "Your Device Not Conected To Internet"),
      );
    }
    try {
      final result = await datasource.getBook(bookId);
      return Success(result);
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode ?? 500;
      return switch (statusCode) {
        HttpStatus.badRequest => Failure(CustomError(message: "Bad request")),
        HttpStatus.notFound => Failure(CustomError(message: "Data Not Found")),
        _ => Failure(CustomError(message: "Server Error")),
      };
    } catch (error) {
      return Failure(
        CustomError(message: "something when wrong !"),
      );
    }
  }
}
