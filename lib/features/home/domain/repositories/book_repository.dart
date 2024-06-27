import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

import '../../../../core/errors/errors_handling.dart';

abstract class BookRepository {
  Future<Result<BookResponse, Exception>> getBooks(BookParams params);
  Future<Result<Book, Exception>> getBook(int bookId);
}
