import 'package:equatable/equatable.dart';

class CustomError extends Equatable implements Exception {
  final String message;
  CustomError({required this.message});

  @override
  List<Object?> get props => [message];
}
