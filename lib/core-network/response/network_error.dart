
import 'package:equatable/equatable.dart';

/// A default value for HTTP codes when response does not have the value
const int httpStatusCodeNotSet = -1;

///A basic type for any error appeared during the network request
sealed class NetworkError extends Equatable {}

///A class for the standard HTTP errors
class HttpError extends NetworkError {
  final int httpCode;
  final Exception? exception;

  HttpError({required this.httpCode, this.exception});

  @override
  List<Object?> get props => [httpCode, exception];
}

///A class for an internal API errors
class ApiError extends NetworkError {
  final int errorCode;
  final String message;

  ApiError({required this.errorCode, this.message = ""});

  @override
  List<Object?> get props => [errorCode, message];
}

///A class for cases when API returned not valid data
class NoDataParsed extends NetworkError {
  @override
  List<Object?> get props => [];
}