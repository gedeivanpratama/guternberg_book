part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookFailure extends BookState {
  final String message;

  BookFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class BookLoaded extends BookState {
  final BookResponse data;

  BookLoaded copyWith({BookResponse? data, Book? detail}) => BookLoaded(
        data: data ?? this.data,
      );

  BookLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
