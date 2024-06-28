import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';

import '../../../domain/repositories/book_repository.dart';

part 'detail_book_event.dart';
part 'detail_book_state.dart';

class DetailBookBloc extends Bloc<DetailBookEvent, DetailBookState> {
  final BookRepository repository;
  DetailBookBloc({required this.repository}) : super(DetailBookInitial()) {
    on<DetailBookRefresh>(_onDetailRefresh);
  }

  FutureOr<void> _onDetailRefresh(DetailBookRefresh event, emit) async {
    emit(DetailBookLoading());
    final result = await repository.getBook(event.bookId);

    if (result case Failure(exception: final error as CustomError)) {
      emit(DetailBookFailure(message: error.message));
    }

    if (result case Success(value: final detail)) {
      emit(DetailBookLoaded(detail: detail));
    }
  }
}
