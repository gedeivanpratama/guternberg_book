part of 'detail_book_bloc.dart';

sealed class DetailBookEvent extends Equatable {
  const DetailBookEvent();

  @override
  List<Object> get props => [];
}

class DetailBookRefresh extends DetailBookEvent {
  const DetailBookRefresh({required this.bookId});

  final int bookId;

  @override
  List<Object> get props => [bookId];
}
