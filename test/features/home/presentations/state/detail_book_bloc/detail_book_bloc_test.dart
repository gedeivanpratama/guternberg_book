import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';
import 'package:guternberg_book/features/home/presentations/state/detail_book_bloc/detail_book_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late MockBookRepository repository;

  setUp(() {
    repository = MockBookRepository();
  });

  group(DetailBookBloc, () {
    blocTest(
      "emit DetailBlocLoad when triggred event DetailBookRefresh",
      build: () {
        when(() => repository.getBook(1)).thenAnswer(
          (_) async => Success(Book()),
        );
        return DetailBookBloc(repository: repository);
      },
      act: (bloc) => bloc.add(DetailBookRefresh(bookId: 1)),
      expect: () => [
        DetailBookLoading(),
        DetailBookLoaded(detail: Book()),
      ],
    );

    blocTest(
      "emit DetailBlocFailure when triggred event DetailBookRefresh",
      build: () {
        when(() => repository.getBook(1)).thenAnswer(
          (_) async => Failure(CustomError(message: "Server Error")),
        );
        return DetailBookBloc(repository: repository);
      },
      act: (bloc) => bloc.add(DetailBookRefresh(bookId: 1)),
      expect: () => [
        DetailBookLoading(),
        DetailBookFailure(message: "Server Error"),
      ],
    );
  });
}
