///A named types for all the HTTP response codes with its values
enum HttpResponseCodeType {
  unknown(httpCode: -1),
  success(httpCode: 200);

  const HttpResponseCodeType({required this.httpCode});

  final int httpCode;
}