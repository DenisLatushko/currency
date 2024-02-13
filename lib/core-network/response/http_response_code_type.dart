///A named types for all the HTTP response codes with its values
enum HttpResponseCodeType {
  unknown(httpCode: -1),
  success(httpCode: 200),
  notFound(httpCode: 404),
  serverError(httpCode: 500);

  const HttpResponseCodeType({required this.httpCode});

  final int httpCode;
}