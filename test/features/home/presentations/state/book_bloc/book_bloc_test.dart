import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';
import 'package:guternberg_book/features/home/presentations/state/book_bloc/book_bloc.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helper/fixture.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late MockBookRepository bookRepository;

  final jsonData = jsonDecode(fixture('book_response.json'));
  final jsonDataMore = jsonDecode(fixture('book_response_more.json'));

  final response = BookResponse.fromJson(jsonData);
  final responseMore = BookResponse.fromJson(jsonDataMore);

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

    blocTest<BookBloc, BookState>(
      "emit  BookLoaded when trigrered BookLoadMore event",
      build: () {
        when(() => bookRepository.getBooks(BookParams(page: "2"))).thenAnswer(
          (_) async => Success(BookResponse.fromJson(jsonDataMore)),
        );
        return BookBloc(repository: bookRepository);
      },
      seed: () => BookLoaded(data: BookResponse.fromJson(jsonData)),
      act: (bloc) => bloc.add(BookLoadMore(BookParams(page: "2"))),
      expect: () => [
        BookLoaded(
          data: response.copyWith(
            previous: responseMore.previous,
            next: responseMore.next,
            books: [...response.books, ...responseMore.books],
          ),
        ),
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
