import 'package:dio/dio.dart';

final class RequestQueryParamsInterceptor extends Interceptor {

  Map<String, String> paramsMap;

  RequestQueryParamsInterceptor(this.paramsMap);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(paramsMap);
    super.onRequest(options, handler);
  }
}