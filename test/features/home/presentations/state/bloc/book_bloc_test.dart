import 'package:bloc_test/bloc_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';
import 'package:guternberg_book/features/home/presentations/state/bloc/book_bloc.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late MockBookRepository bookRepository;

  setUpAll(() {
    bookRepository = MockBookRepository();
  });

  group("get books", () {
    test("first state is BookInitial", () {
      expect(BookBloc(repository: bookRepository).state, BookInitial());
    });

    blocTest(
      "emit  BookLoaded when trigrered BookFetch event",
      build: () {
        when(() => bookRepository.getBooks(BookParams(page: "1"))).thenAnswer(
          (_) async => Success(BookResponse()),
        );
        return BookBloc(repository: bookRepository);
      },
      act: (bloc) => bloc.add(BookFetch(BookParams(page: "1"))),
      expect: () => [
        BookLoading(),
        BookLoaded(data: BookResponse()),
      ],
    );

    blocTest(
      "emit  BookFailure when trigrered BookFetch event",
      build: () {
        when(() => bookRepository.getBooks(BookParams(page: "1"))).thenAnswer(
          (_) async => Failure(CustomError(message: "Server Error")),
        );
        return BookBloc(repository: bookRepository);
      },
      act: (bloc) => bloc.add(BookFetch(BookParams(page: "1"))),
      expect: () => [
        BookLoading(),
        BookFailure(message: "Server Error"),
      ],
    );
  });
}
