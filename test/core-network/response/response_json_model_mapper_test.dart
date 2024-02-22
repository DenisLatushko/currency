import 'package:currency/core-currency-api/response/error_response.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-network/response/response_json_model_mapper.dart';
import 'package:currency/core-utils/json.dart';
import 'package:currency/core-utils/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../utils/expect.dart';
import '../../utils/function.dart';
import 'response_json_model_mapper_test.mocks.dart';

///Tests for [ResponseJsonModelMapper]
@GenerateMocks([Json, Function1])
void main() {
  const ErrorResponse errorResponse = ErrorResponse(success: false, error: ErrorDataResponse(code: 104, info: "Message"));
  const ErrorResponse errorNoInfoResponse = ErrorResponse(success: false, error: ErrorDataResponse(code: 104, info: null));
  const Object responseValue = Object();

  late Map<String, dynamic> jsonMapSuccessTrue = {'success': true};
  late Map<String, dynamic> jsonMapSuccessFalse = {'success': false};
  late Map<String, dynamic> jsonMapError = {'error': {}};

  late MockJson jsonMock;
  late MockFunction1<Object, Map<String, dynamic>> successResponseMapperMock;
  late MockFunction1<ErrorResponse, Map<String, dynamic>> errorResponseMapperMock;
  late ResponseJsonModelMapper<Object> mapper;

  setUp(() {
    provideDummy(errorResponse);
    jsonMock = MockJson();
    successResponseMapperMock = MockFunction1<Object, Map<String, dynamic>>();
    errorResponseMapperMock = MockFunction1<ErrorResponse, Map<String, dynamic>>();
    mapper = ResponseJsonModelMapper(jsonMock, successResponseMapperMock, errorResponseMapperMock);

    when(successResponseMapperMock.call(any)).thenReturn(responseValue);
  });

  void expectNoDataParsedError(Result<Object, NetworkError> actualResult) {
    expectTrue(actualResult is Error);
    expectTrue(actualResult.asError().error is NoDataParsed);
  }

  test('Given no JSON data when call mapper then no data error returned', () {
    Result<Object, NetworkError> actualResult = mapper(null);

    expectNoDataParsedError(actualResult);
  });

  test('Given non-valid JSON string data when call mapper then no data error returned', () {
    when(jsonMock.decode(any)).thenReturn(null);

    Result<Object, NetworkError> actualResult = mapper("");

    expectNoDataParsedError(actualResult);
  });

  void expectApiError(Result<Object, NetworkError> actualResult) {
    expectTrue(actualResult is Error);
    expectTrue(actualResult.asError().error is ApiError);
  }

  test('Given full info error JSON string data when call mapper then api error returned', () {
    when(errorResponseMapperMock.call(any)).thenReturn(errorResponse);
    when(jsonMock.decode(any)).thenReturn(jsonMapError);

    Result<Object, NetworkError> actualResult = mapper("");

    expectApiError(actualResult);
  });

  test('Given empty info error JSON string data when call mapper then api error returned', () {
    when(errorResponseMapperMock.call(any)).thenReturn(errorNoInfoResponse);
    when(jsonMock.decode(any)).thenReturn(jsonMapError);

    Result<Object, NetworkError> actualResult = mapper("");

    expectApiError(actualResult);
  });

  test('Given not success JSON string data when call mapper then api error returned', () {
    when(errorResponseMapperMock.call(any)).thenReturn(errorNoInfoResponse);
    when(jsonMock.decode(any)).thenReturn(jsonMapSuccessFalse);

    Result<Object, NetworkError> actualResult = mapper("");

    expectApiError(actualResult);
  });

  test('Given full info error JSON string data when call mapper then api error has full info', () {
    when(errorResponseMapperMock.call(any)).thenReturn(errorResponse);
    when(jsonMock.decode(any)).thenReturn(jsonMapError);

    ApiError actualResult = mapper("").asError().error! as ApiError;

    expect(actualResult.errorCode, errorResponse.error!.code);
    expect(actualResult.message, errorResponse.error!.info);
  });

  test('Given empty info error JSON string data when call mapper then api error has only code', () {
    when(errorResponseMapperMock.call(any)).thenReturn(errorNoInfoResponse);
    when(jsonMock.decode(any)).thenReturn(jsonMapError);

    ApiError actualResult = mapper("").asError().error! as ApiError;

    expect(actualResult.errorCode, errorResponse.error!.code);
    expect(actualResult.message, "");
  });

  test('Given success data JSON string when call mapper then result success', () {
    when(jsonMock.decode(any)).thenReturn(jsonMapSuccessTrue);

    Result<Object, NetworkError> actualResult = mapper("");

    expectTrue(actualResult is Success);
    expect(actualResult.asSuccess().data, responseValue);
  });
}
