import '../response/http_response_code_type.dart';

///A mapper to convert a HTTP response code to a named object of [HttpResponseCodeType]
class HttpResponseCodeMapper {

  HttpResponseCodeType call(int httpCode) {
    return HttpResponseCodeType.values
        .firstWhere((element) => element.httpCode == httpCode, orElse: () => HttpResponseCodeType.unknown);
  }
}