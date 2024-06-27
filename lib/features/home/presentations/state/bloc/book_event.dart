part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class BookFetch extends BookEvent {
  final BookParams params;

  BookFetch(this.params);

  @override
  List<Object> get props => [params];
}

class BookDetailFetch extends BookEvent {
  final int bookId;

  BookDetailFetch(this.bookId);

  @override
  List<Object> get props => [bookId];
}

class BookLoadMore extends BookEvent {
  final BookParams params;

  BookLoadMore(this.params);

  @override
  List<Object> get props => [params];
}
