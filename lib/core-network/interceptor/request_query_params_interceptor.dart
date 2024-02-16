import 'package:dio/dio.dart';

///An interceptor to constantly add necessary parameters to a query parameters of http request
final class RequestQueryParamsInterceptor extends Interceptor {

  Map<String, String> paramsMap;

  RequestQueryParamsInterceptor(this.paramsMap);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(paramsMap);
    super.onRequest(options, handler);
  }
}
