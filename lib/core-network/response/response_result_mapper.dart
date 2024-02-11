import 'dart:io';
import 'package:currency/core-network/response/json_model_mapper.dart';
import 'package:http/http.dart';
import '../../core-utils/result.dart';
import 'http_response_code_mapper.dart';
import 'http_response_code_type.dart';

///A mapper to convert [Response] from the remote server to an object with data from the response body
class ResponseResultMapper {

  final HttpResponseCodeMapper _httpResponseCodeMapper;

  ResponseResultMapper(this._httpResponseCodeMapper);

  ///A function to do the conversion
  ///[response] is a response object received from the HTTP framework as a result of HTTP request
  ///[jsonMapper] a [Function] which is called to convert JSON to the object. The conversion process is placed in
  ///additional classes (e.g. [RateDataModelMapper])
  Result<T> call<T>(final Response response, final JsonModelMapper<T> jsonMapper) {
    HttpResponseCodeType httpResponseCodeType = _httpResponseCodeMapper(response.statusCode);

    return switch(httpResponseCodeType) {
      HttpResponseCodeType.success => Success(jsonMapper(response.body)),
      _ => HttpError(responseCodeType: httpResponseCodeType, exception: HttpException(response.reasonPhrase ?? ""))
    };
  }
}