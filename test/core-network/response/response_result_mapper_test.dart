import 'dart:io';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';
import 'package:currency/core-network/response/response_result_mapper.dart';
import 'package:currency/core-utils/result.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../utils/expect.dart';

import 'response_result_mapper_test.mocks.dart';

///Tests for [ResponseResultMapper]
@GenerateMocks([Response, ResponseModelMapper])
void main() {
  const httpSuccessCode = 200;
  const httpFailedCode = 500;
  const successResponseBodyData = "SUCCESS_RESPONSE_BODY";
  const errorResponseBodyData = "ERROR_RESPONSE_BODY";
  const responsePhraseData = "RESPONSE_PHRASE";
  const mappedValue = "MAPPED_VALUE";

  final successResponseModel = Success<String, NetworkError>(mappedValue);
  late MockResponse responseMock;
  late MockResponseModelMapper<String> responseModelMapper;

  late ResponseResultMapper mapper;

  setUp(() {
    responseMock = MockResponse();
    responseModelMapper = MockResponseModelMapper<String>();
    mapper = ResponseResultMapper();

    when(responseModelMapper(successResponseBodyData)).thenReturn(successResponseModel);
  });

  group('Tests with success response', () {
    provideDummy<Result<String, NetworkError>>(successResponseModel);

    setUp(() {
      when(responseMock.statusCode).thenReturn(httpSuccessCode);
      when(responseMock.data).thenReturn(successResponseBodyData);
      when(responseMock.statusMessage).thenReturn(responsePhraseData);
    });

    test('Given success response when call mapper then result contains the correct value', () {
      Result<String, NetworkError> actualResult = mapper.call<String>(responseMock, responseModelMapper);

      expectTrue(actualResult is Success<String, NetworkError>);
      expect(actualResult.asSuccess().data, mappedValue);
    });

    test('Given success response when call mapper then all instances are called correctly', () {
      mapper.call<String>(responseMock, responseModelMapper);

      verify(responseModelMapper(successResponseBodyData)).called(1);
    });
  });

  group('Tests with failed response', () {
    setUp(() {
      when(responseMock.statusCode).thenReturn(httpFailedCode);
      when(responseMock.data).thenReturn(errorResponseBodyData);
      when(responseMock.statusMessage).thenReturn(responsePhraseData);
    });

    test('Given failed response when call mapper then result is HttpError', () {
      Result<String, NetworkError> actualResult = mapper.call<String>(responseMock, responseModelMapper);

      expectTrue(actualResult is Error<String, NetworkError>);
      expectTrue(actualResult.asError().error is HttpError);
    });

    test('Given failed response when call mapper then result contains http code', () {
      int actualResult = mapper.call<String>(responseMock, responseModelMapper)
          .asError()
          .toHttpError()
          .httpCode;

      expect(actualResult, httpFailedCode);
    });

    test('Given failed response when call mapper then result contains HttpException', () {
      Exception? actualResult = mapper.call<String>(responseMock, responseModelMapper)
          .asError()
          .toHttpError()
          .exception;

      expectTrue(actualResult != null);
      expectTrue(actualResult is HttpException);
    });

    test('Given failed response when call mapper then result contains HttpException', () {
      String actualResult = mapper.call<String>(responseMock, responseModelMapper)
          .asError()
          .toHttpError()
          .exception
          .toHttpException()
          .message;

      expect(actualResult, responsePhraseData);
    });

    test('Given failed response when call mapper then then all instances are called correctly', () {
      mapper.call<String>(responseMock, responseModelMapper);

      verifyZeroInteractions(responseModelMapper);
    });
  });
}

extension _ErrorExt on Error<String, NetworkError> {
  HttpError toHttpError() => error as HttpError;
}

extension _ExceptionExt on Exception? {
  HttpException toHttpException() => this as HttpException;
}
