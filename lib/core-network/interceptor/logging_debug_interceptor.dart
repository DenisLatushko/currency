import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingDebugInterceptor extends LogInterceptor {

  LoggingDebugInterceptor({
    super.request = true,
    super.requestHeader = true,
    super.requestBody = false,
    super.responseHeader = true,
    super.responseBody = false,
    super.error = true,
    super.logPrint = _debugPrint,
  }) : super ();

  factory LoggingDebugInterceptor.all([Function(Object object) logPrint = _debugPrint]) =>
      LoggingDebugInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true,
        responseBody: true, error: true, logPrint: logPrint);

}

void _debugPrint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
