import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

abstract class BookRemoteDatasource {
  Future<BookResponse> getBooks(BookParams params);
}
