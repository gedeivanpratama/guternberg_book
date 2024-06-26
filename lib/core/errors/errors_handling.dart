import 'package:equatable/equatable.dart';

sealed class Result<S, E extends Exception> extends Equatable {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;

  @override
  List<Object?> get props => [value];
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;

  @override
  List<Object?> get props => [exception];
}
