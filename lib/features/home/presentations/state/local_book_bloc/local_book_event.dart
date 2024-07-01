part of 'local_book_bloc.dart';

sealed class LocalBookEvent extends Equatable {
  const LocalBookEvent();

  @override
  List<Object> get props => [];
}

class LocalBookLikePressed extends LocalBookEvent {
  const LocalBookLikePressed(this.params);
  final Book params;
  @override
  List<Object> get props => [params];
}

class LocalBookDisLikePressed extends LocalBookEvent {
  const LocalBookDisLikePressed(this.params);
  final Book params;
  @override
  List<Object> get props => [params];
}

class LocalBookFetch extends LocalBookEvent {}
