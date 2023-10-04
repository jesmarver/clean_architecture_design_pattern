import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  APIException({required this.message, required this.statusCode});

  @override
  // TODO: implement props
  List<Object?> get props => [message, statusCode];
}
