import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/core/global/data/datasources/book_local_datasource.dart';
import 'package:guternberg_book/core/global/data/repositories/book_local_repository_imp.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockBookLocalDataSource extends Mock implements BookLocalDataSource {}

void main() {
  late MockBookLocalDataSource mockDataSource;
  late BookLocalRepositoryImp repository;

  setUp(() {
    mockDataSource = MockBookLocalDataSource();
    repository = BookLocalRepositoryImp(datasource: mockDataSource);
  });

  group('BookLocalRepositoryImp', () {
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

    test('should return list of books on success', () async {
      when(() => mockDataSource.getBooks()).thenAnswer((_) async => [book]);

      final result = await repository.getBooks();

      expect(result, Success([book]));
      verify(() => mockDataSource.getBooks()).called(1);
    });

    test('should return failure on getBooks error', () async {
      when(() => mockDataSource.getBooks()).thenThrow(Exception());

      final result = await repository.getBooks();

      final failure = result as Failure<List<Book>, Exception>;
      expect(result, isA<Failure<List<Book>, Exception>>());
      expect((failure.exception as CustomError).message,
          equals('something when wrong !'));
      verify(() => mockDataSource.getBooks()).called(1);
    });

    test('should like a book successfully', () async {
      when(() => mockDataSource.likeBook(book)).thenAnswer((_) async => true);

      final result = await repository.likeBook(book);

      expect(result, Success(true));
      verify(() => mockDataSource.likeBook(book)).called(1);
    });

    test('should return failure on likeBook error', () async {
      when(() => mockDataSource.likeBook(book)).thenThrow(Exception());

      final result = await repository.likeBook(book);

      final failure = result as Failure<bool, Exception>;
      expect(result, isA<Failure<bool, Exception>>());
      expect((failure.exception as CustomError).message,
          equals('something when wrong !'));
      verify(() => mockDataSource.likeBook(book)).called(1);
    });

    test('should dislike a book successfully', () async {
      when(() => mockDataSource.disLikeBook(book))
          .thenAnswer((_) async => true);

      final result = await repository.disLikeBook(book);

      expect(result, Success(true));
      verify(() => mockDataSource.disLikeBook(book)).called(1);
    });

    test('should return failure on disLikeBook error', () async {
      when(() => mockDataSource.disLikeBook(book)).thenThrow(Exception());

      final result = await repository.disLikeBook(book);

      final failure = result as Failure<bool, Exception>;
      expect(result, isA<Failure<bool, Exception>>());
      expect((failure.exception as CustomError).message,
          equals('something when wrong !'));
      verify(() => mockDataSource.disLikeBook(book)).called(1);
    });
  });
}
