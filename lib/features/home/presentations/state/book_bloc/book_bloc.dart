import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/domain/repositories/book_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'book_event.dart';
part 'book_state.dart';

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;
  BookBloc({required this.repository}) : super(BookInitial()) {
    on<BookFetch>(_onBookFetch);
    on<BookLoadMore>(
      _onBookLoadMore,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _onBookLoadMore(BookLoadMore event, emit) async {
    if (state is! BookLoaded) return;
    if ((state as BookLoaded).data.next.isEmpty) return;

    final prevState = (state as BookLoaded);
    final params = event.params
        .copyWith(page: prevState.data.next[prevState.data.next.length - 1]);
    final result = await repository.getBooks(params);

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
            books: List.of(prevState.data.books)..addAll(data.books),
          ),
        ),
      );
    }
  }

  FutureOr<void> _onBookFetch(BookFetch event, emit) async {
    if (state is BookLoaded && !event.isReload) return;

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
