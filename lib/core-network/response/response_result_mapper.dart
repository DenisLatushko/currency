import 'dart:io';

import 'package:currency/core-network/request/api_request.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/num_ext.dart';
import 'package:currency/core-utils/result.dart';
import 'package:dio/dio.dart';

///A mapper to convert [Response] from the remote server to an object with data from the response body
class ResponseResultMapper {

  static const int _httpSuccessCodesStart = 200;
  static const int _httpSuccessCodesEnd = 299;

  ///A function to do the conversion
  ///[response] is a response object received from the HTTP framework as a result of HTTP request
  ///[jsonMapper] a [Function] which is called to convert response to an object
  Result<S, NetworkError> call<S>(final Response response, final ResponseModelMapperFunction<S> responseModelMapper) {
    int statusCode = response.statusCode ?? httpStatusCodeNotSet;
    return switch(statusCode.isBetween(_httpSuccessCodesStart, _httpSuccessCodesEnd, incLeft: true, incRight: true)) {
      true => responseModelMapper(response.data),
      false => getHttpError(statusCode, response.statusMessage ?? "")
    };
  }

  Result<S, NetworkError> getHttpError<S>(int httpCode, String statusMessage) {
    HttpError httpError = HttpError(httpCode: httpCode, exception: HttpException(statusMessage));
    return Error<S, NetworkError>(httpError);
  }
}
