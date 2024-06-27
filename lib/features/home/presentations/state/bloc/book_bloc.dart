import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;
  BookBloc({required this.repository}) : super(BookInitial()) {
    on<BookFetch>(_onBookFetch);
    on<BookLoadMore>(_onBookLoadMore);
  }

  FutureOr<void> _onBookLoadMore(BookLoadMore event, emit) async {
    if (state is! BookLoaded) return;

    final prevState = (state as BookLoaded);

    final result = await repository.getBooks(event.params);

    if (result case Failure(exception: final error as CustomError)) {
      emit(BookFailure(message: error.message));
    }

    if (result case Success(value: final data)) {
      emit(
        prevState.copyWith(
          data: prevState.data.copyWith(
            next: data.next,
            count: data.count,
            previous: data.previous,
            books: [...prevState.data.books, ...data.books],
          ),
        ),
      );
    }
  }

  FutureOr<void> _onBookFetch(BookFetch event, emit) async {
    emit(BookLoading());

    final result = await repository.getBooks(event.params);

    if (result case Failure(exception: final error as CustomError)) {
      emit(BookFailure(message: error.message));
    }

    if (result case Success(value: final data)) {
      emit(BookLoaded(data: data));
    }
  }
}
