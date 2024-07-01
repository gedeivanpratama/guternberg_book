import 'package:guternberg_book/core/db/db_service.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';

abstract class BookLocalDataSource {
  Future<List<Book>> getBooks();
  Future<Book> getBook(Book params);
  Future<bool> disLikeBook(Book params);
  Future<bool> likeBook(Book params);
}

class BookLocalDataSourceImp implements BookLocalDataSource {
  final DBService db;

  BookLocalDataSourceImp({required this.db});

  @override
  Future<List<Book>> getBooks() async {
    try {
      final database = await db.openConnection();
      return database.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> likeBook(Book params) async {
    try {
      final database = await db.openConnection();
      await database.put("${params.id}", params.copyWith(like: true));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> disLikeBook(Book params) async {
    try {
      final database = await db.openConnection();
      await database.put("${params.id}", params.copyWith(disLike: true));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Book> getBook(Book params) async {
    try {
      final database = await db.openConnection();
      return database.values.firstWhere((element) => element == params);
    } catch (e) {
      rethrow;
    }
  }
}
