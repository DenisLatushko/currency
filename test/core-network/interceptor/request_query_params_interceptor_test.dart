import 'package:currency/core-network/interceptor/request_query_params_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'request_query_params_interceptor_test.mocks.dart';

///Tests for [RequestQueryParamsInterceptor]
@GenerateMocks([RequestOptions, RequestInterceptorHandler])
void main() {
  const String key = 'key';
  const String value = 'value';

  late Map<String, dynamic> requestQueryParameters;
  late MockRequestOptions requestOptionsMock;
  late MockRequestInterceptorHandler requestInterceptorHandlerMock;

  final RequestQueryParamsInterceptor interceptor = RequestQueryParamsInterceptor({key: value});

  setUp(() {
    requestOptionsMock = MockRequestOptions();
    requestInterceptorHandlerMock = MockRequestInterceptorHandler();
    requestQueryParameters = {};
    when(requestOptionsMock.queryParameters).thenReturn(requestQueryParameters);
  });

  test('Given params map when call request then params added to request', () {
    interceptor.onRequest(requestOptionsMock, requestInterceptorHandlerMock);

    expect(requestQueryParameters[key], value);
  });
}