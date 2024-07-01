import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/core/global/domain/repositories/book_local_repository.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/liked_book/presentations/state/local_book_bloc/local_book_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockBookLocalRepository extends Mock implements BookLocalRepository {}

void main() {
  late MockBookLocalRepository mockRepository;
  late LocalBookBloc bloc;

  setUp(() {
    mockRepository = MockBookLocalRepository();
    bloc = LocalBookBloc(repository: mockRepository);
  });

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

  group('LocalBookBloc', () {
    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookLoaded] when LocalBookFetch is added and succeeds',
      build: () {
        when(() => mockRepository.getBooks())
            .thenAnswer((_) async => Success([book]));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookFetch()),
      expect: () => [
        LocalBookLoading(),
        LocalBookLoaded(books: [book]),
      ],
      verify: (_) {
        verify(() => mockRepository.getBooks()).called(1);
      },
    );

    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookFailure] when LocalBookFetch is added and fails',
      build: () {
        when(() => mockRepository.getBooks()).thenAnswer(
            (_) async => Failure(CustomError(message: 'something went wrong')));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookFetch()),
      expect: () => [
        LocalBookLoading(),
        LocalBookFailure(message: 'something went wrong'),
      ],
      verify: (_) {
        verify(() => mockRepository.getBooks()).called(1);
      },
    );

    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookUpdated] when LocalBookLikePressed is added and succeeds',
      build: () {
        when(() => mockRepository.likeBook(book))
            .thenAnswer((_) async => Success(true));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookLikePressed(book)),
      expect: () => [
        LocalBookLoading(),
        LocalBookUpdated(bookName: book.title, isLiked: true),
      ],
      verify: (_) {
        verify(() => mockRepository.likeBook(book)).called(1);
      },
    );

    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookFailure] when LocalBookLikePressed is added and fails',
      build: () {
        when(() => mockRepository.likeBook(book)).thenAnswer(
            (_) async => Failure(CustomError(message: 'something went wrong')));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookLikePressed(book)),
      expect: () => [
        LocalBookLoading(),
        LocalBookFailure(message: 'something went wrong'),
      ],
      verify: (_) {
        verify(() => mockRepository.likeBook(book)).called(1);
      },
    );

    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookUpdated] when LocalBookDisLikePressed is added and succeeds',
      build: () {
        when(() => mockRepository.disLikeBook(book))
            .thenAnswer((_) async => Success(true));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookDisLikePressed(book)),
      expect: () => [
        LocalBookLoading(),
        LocalBookUpdated(bookName: book.title, isLiked: false),
      ],
      verify: (_) {
        verify(() => mockRepository.disLikeBook(book)).called(1);
      },
    );

    blocTest<LocalBookBloc, LocalBookState>(
      'emits [LocalBookLoading, LocalBookFailure] when LocalBookDisLikePressed is added and fails',
      build: () {
        when(() => mockRepository.disLikeBook(book)).thenAnswer(
            (_) async => Failure(CustomError(message: 'something went wrong')));
        return bloc;
      },
      act: (bloc) => bloc.add(LocalBookDisLikePressed(book)),
      expect: () => [
        LocalBookLoading(),
        LocalBookFailure(message: 'something went wrong'),
      ],
      verify: (_) {
        verify(() => mockRepository.disLikeBook(book)).called(1);
      },
    );
  });
}
