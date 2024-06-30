part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class BookFetch extends BookEvent {
  final BookParams params;
  final bool isReload;

  BookFetch(this.params, {this.isReload = false});

  @override
  List<Object> get props => [params, isReload];
}

class BookLoadMore extends BookEvent {
  final BookParams params;

  BookLoadMore(this.params);

  @override
  List<Object> get props => [params];
}
