import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/core/db/db_service.dart';
import 'package:guternberg_book/core/global/data/datasources/book_local_datasource.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockDBService extends Mock implements DBService {}

class MockBox<T> extends Mock implements Box<T> {}

void main() {
  late MockDBService mockDBService;
  late MockBox<Book> mockBox;
  late BookLocalDataSourceImp dataSource;

  setUp(() {
    mockDBService = MockDBService();
    mockBox = MockBox<Book>();
    dataSource = BookLocalDataSourceImp(db: mockDBService);
  });

  group('BookLocalDataSourceImp', () {
    final book = Book(
      id: 1,
      title: 'Test Book',
      authors: [Author(name: 'Author 1', birthYear: 1970, deathYear: 2020)],
      translators: [],
      subjects: ['Subject 1'],
      bookshelves: ['Bookshelf 1'],
      languages: ['en'],
      copyright: true,
      mediaType: 'text',
      downloadCount: 100,
      formats: Formats(image: 'image_url', webviewUrl: 'webview_url'),
      like: false,
      disLike: false,
    );

    test('should return list of books', () async {
      when(() => mockDBService.openConnection())
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.values).thenReturn([book]);

      final result = await dataSource.getBooks();

      expect(result, [book]);
      verify(() => mockDBService.openConnection()).called(1);
    });

    test('should return a book by params', () async {
      when(() => mockDBService.openConnection())
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.values).thenReturn([book]);

      final result = await dataSource.getBook(book);

      expect(result, book);
      verify(() => mockDBService.openConnection()).called(1);
    });

    test('should like a book', () async {
      when(() => mockDBService.openConnection())
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.put('${book.id}', book.copyWith(like: true)))
          .thenAnswer((_) async => Future.value());

      final result = await dataSource.likeBook(book);

      expect(result, true);
      verify(() => mockDBService.openConnection()).called(1);
      verify(() => mockBox.put('${book.id}', book.copyWith(like: true)))
          .called(1);
    });

    test('should dislike a book', () async {
      when(() => mockDBService.openConnection())
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.put('${book.id}', book.copyWith(disLike: true)))
          .thenAnswer((_) async => book);

      final result = await dataSource.disLikeBook(book);

      expect(result, true);
      verify(() => mockDBService.openConnection()).called(1);
      verify(() => mockBox.put('${book.id}', book.copyWith(disLike: true)))
          .called(1);
    });
  });
}
