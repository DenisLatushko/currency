import 'dart:io';
import 'package:currency/core-network/response/http_response_code_mapper.dart';
import 'package:currency/core-network/response/http_response_code_type.dart';
import 'package:currency/core-network/response/json_model_mapper.dart';
import 'package:currency/core-network/response/response_result_mapper.dart';
import 'package:currency/core-utils/result.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../utils/expect.dart';
import 'response_result_mapper_test.mocks.dart';

///Tests for [ResponseResultMapper]
@GenerateMocks([HttpResponseCodeMapper, Response, JsonModelMapper])
void main() {
  const httpSuccessCode = 200;
  const httpFailedCode = 500;
  const responseBodyData = "RESPONSE_BODY";
  const responsePhraseData = "RESPONSE_PHRASE";
  const mappedValue = "MAPPED_VALUE";

  late Response responseMock;
  late MockJsonModelMapper<String> stringMapperMock;
  late MockHttpResponseCodeMapper httpResponseCodeMapperMock;

  late ResponseResultMapper mapper;

  setUp(() {
    responseMock = MockResponse();
    when(responseMock.data).thenReturn(responseBodyData);

    stringMapperMock = MockJsonModelMapper<String>();
    when(stringMapperMock(responseBodyData)).thenReturn(mappedValue);

    httpResponseCodeMapperMock = MockHttpResponseCodeMapper();
    when(httpResponseCodeMapperMock.call(httpSuccessCode)).thenReturn(HttpResponseCodeType.success);
    when(httpResponseCodeMapperMock.call(httpFailedCode)).thenReturn(HttpResponseCodeType.unknown);

    mapper = ResponseResultMapper(httpResponseCodeMapperMock);
  });

  group('Tests with success response', () {
    setUp(() => when(responseMock.statusCode).thenReturn(httpSuccessCode));

    test('Given success response when call mapper then result contains the correct value', () {
      Result<String> actualResult = mapper.call<String>(responseMock, stringMapperMock);

      expectTrue(actualResult is Success<String>);
      expect(actualResult.asSuccess().data, mappedValue);
    });

    test('Given success response when call mapper then all instances are called correctly', () {
      mapper.call<String>(responseMock, stringMapperMock);

      verify(httpResponseCodeMapperMock.call(httpSuccessCode)).called(1);
      verify(stringMapperMock.call(responseBodyData)).called(1);
    });
  });

  group('Tests with failed response', () {
    setUp(() {
      when(responseMock.statusCode).thenReturn(httpFailedCode);
      when(responseMock.statusMessage).thenReturn(responsePhraseData);
    });

    test('Given failed response when call mapper then result contains the correct value', () {
      Result<String> actualResult = mapper.call<String>(responseMock, stringMapperMock);

      expectTrue(actualResult is HttpError<String>);
      expect(actualResult.asHttpError().responseCodeType, HttpResponseCodeType.unknown);
    });

    test('Given failed response with reason phrase when call mapper then result contains the reason phrase', () {
      Result<String> actualResult = mapper.call<String>(responseMock, stringMapperMock);

      expectTrue(actualResult.asHttpError().exception is HttpException);
      expect((actualResult.asHttpError().exception as HttpException).message, responsePhraseData);
    });

    test('Given failed response without reason phrase when call mapper then result contains the empty string', () {
      when(responseMock.statusMessage).thenReturn(null);

      Result<String> actualResult = mapper.call<String>(responseMock, stringMapperMock);

      expectTrue(actualResult.asHttpError().exception is HttpException);
      expect((actualResult.asHttpError().exception as HttpException).message, "");
    });

    test('Given failed response when call mapper then then all instances are called correctly', () {
      mapper.call<String>(responseMock, stringMapperMock);

      verify(httpResponseCodeMapperMock.call(httpFailedCode)).called(1);
      verifyZeroInteractions(stringMapperMock);
    });
  });
}
