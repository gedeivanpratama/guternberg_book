import 'package:dio/dio.dart';
import 'package:guternberg_book/core/utils/flavor_settings.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

abstract class BookRemoteDatasource {
  Future<BookResponse> getBooks(BookParams params);
  Future<Book> getBook(int id);
}

class BookRemoteDatasourceImp implements BookRemoteDatasource {
  final Dio dio;
  final FlavorSetting flavorSetting;

  BookRemoteDatasourceImp({
    required this.dio,
    required this.flavorSetting,
  });

  @override
  Future<BookResponse> getBooks(BookParams params) async {
    try {
      final response = await dio.get(
        "${flavorSetting.baseUrl}/books",
        queryParameters: params.queryParams(),
      );
      return BookResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Book> getBook(int id) async {
    try {
      final response = await dio.get(
        "${flavorSetting.baseUrl}/book/$id",
      );
      return Book.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
