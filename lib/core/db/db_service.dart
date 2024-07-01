import 'package:hive/hive.dart';

import '../../features/home/data/models/book_response.dart';

class DBService {
  DBService._privateConstructor();

  static final DBService _instance = DBService._privateConstructor();

  factory DBService() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(AuthorAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(FormatsAdapter());
    }
    return _instance;
  }

  static Future<Box<Book>>? _boxFuture;

  Future<Box<Book>> openConnection() async {
    if (_boxFuture == null) {
      _boxFuture = Hive.openBox<Book>('books');
    }
    try {
      var box = await _boxFuture!;
      return box;
    } catch (e) {
      _boxFuture = null;
      throw e;
    }
  }
}
