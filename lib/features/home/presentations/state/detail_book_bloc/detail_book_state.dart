part of 'detail_book_bloc.dart';

sealed class DetailBookState extends Equatable {
  const DetailBookState();

  @override
  List<Object> get props => [];
}

final class DetailBookInitial extends DetailBookState {}

final class DetailBookFailure extends DetailBookState {
  final String message;

  DetailBookFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class DetailBookLoading extends DetailBookState {}

final class DetailBookLoaded extends DetailBookState {
  final Book detail;
  DetailBookLoaded({required this.detail});
  @override
  List<Object> get props => [detail];
}
