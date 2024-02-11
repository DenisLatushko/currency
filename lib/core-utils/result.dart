import 'package:currency/core-network/response/http_response_code_type.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

sealed class Error<T> extends Result<T> {
  final Exception? exception;
  Error({this.exception});
}

class HttpError<T> extends Error<T> {
  final HttpResponseCodeType responseCodeType;

  HttpError({required this.responseCodeType, super.exception});
}

extension ResultExt<T> on Result<T> {
  Success<T> asSuccess() {
    assert(this is Success, 'The current object must be the Success type');
    return this as Success<T>;
  }

  Error<T> asError() {
    assert(this is Error, 'The current object must be the Error type');
    return this as Error<T>;
  }
}

extension ErrorExt<T> on Result<T> {
  HttpError<T> asHttpError() {
    assert(this is HttpError, 'The current object must be the HttpError type');
    return this as HttpError<T>;
  }
}