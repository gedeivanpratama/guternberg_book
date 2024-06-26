import 'package:dio/dio.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

abstract class BookRemoteDatasource {
  Future<BookResponse> getBooks(BookParams params);
}

class BookRemoteDatasourceImp implements BookRemoteDatasource {
  final Dio dio;

  BookRemoteDatasourceImp({required this.dio});

  @override
  Future<BookResponse> getBooks(BookParams params) async {
    try {
      final response = await dio.get(
        "https://gutendex.com/books",
        queryParameters: params.queryParams(),
      );
      return BookResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
