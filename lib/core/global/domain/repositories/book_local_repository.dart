import '../../../../features/home/data/models/book_response.dart';
import '../../../errors/errors_handling.dart';

abstract class BookLocalRepository {
  Future<Result<List<Book>, Exception>> getBooks();
  Future<Result<bool, Exception>> likeBook(Book params);
  Future<Result<bool, Exception>> disLikeBook(Book params);
}
