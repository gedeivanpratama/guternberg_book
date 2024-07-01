part of 'local_book_bloc.dart';

sealed class LocalBookState extends Equatable {
  const LocalBookState();

  @override
  List<Object> get props => [];
}

final class LocalBookInitial extends LocalBookState {}

final class LocalBookUpdated extends LocalBookState {
  final String bookName;
  final bool isLiked;

  LocalBookUpdated({required this.bookName, required this.isLiked});

  @override
  List<Object> get props => [bookName, isLiked];
}

final class LocalBookLoading extends LocalBookState {}

final class LocalBookFailure extends LocalBookState {
  final String message;

  LocalBookFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class LocalBookLoaded extends LocalBookState {
  final List<Book> books;
  LocalBookLoaded({required this.books});
  @override
  List<Object> get props => [books];
}
