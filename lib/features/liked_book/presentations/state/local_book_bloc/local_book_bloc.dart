import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';

import '../../../../../core/errors/error_message.dart';
import '../../../../../core/errors/errors_handling.dart';
import '../../../../../core/global/domain/repositories/book_local_repository.dart';

part 'local_book_event.dart';
part 'local_book_state.dart';

class LocalBookBloc extends Bloc<LocalBookEvent, LocalBookState> {
  final BookLocalRepository repository;
  LocalBookBloc({required this.repository}) : super(LocalBookInitial()) {
    on<LocalBookLikePressed>(_onLike);
    on<LocalBookDisLikePressed>(_onDisLike);

    on<LocalBookFetch>(_onFetch);
  }

  FutureOr<void> _onFetch(LocalBookFetch event, emit) async {
    emit(LocalBookLoading());
    final result = await repository.getBooks();
    if (result case Failure(exception: final error as CustomError)) {
      emit(LocalBookFailure(message: error.message));
    }

    if (result case Success(value: final books)) {
      emit(LocalBookLoaded(books: books));
    }
  }

  FutureOr<void> _onLike(LocalBookLikePressed event, emit) async {
    emit(LocalBookLoading());
    final result = await repository.likeBook(event.params);
    if (result case Failure(exception: final error as CustomError)) {
      emit(LocalBookFailure(message: error.message));
    }

    if (result case Success(value: final _)) {
      emit(LocalBookUpdated(bookName: event.params.title, isLiked: true));
    }
  }

  FutureOr<void> _onDisLike(LocalBookDisLikePressed event, emit) async {
    emit(LocalBookLoading());
    final result = await repository.disLikeBook(event.params);
    if (result case Failure(exception: final error as CustomError)) {
      emit(LocalBookFailure(message: error.message));
    }

    if (result case Success(value: final _)) {
      emit(LocalBookUpdated(
        bookName: event.params.title,
        isLiked: false,
      ));
    }
  }
}
