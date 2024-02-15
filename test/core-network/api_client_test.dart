import 'package:currency/core-network/api_client.dart';
import 'package:currency/core-network/request/api_request.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';
import 'package:currency/core-network/response/response_result_mapper.dart';
import 'package:currency/core-utils/result.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'api_client_test.mocks.dart';

///Tests for [ApiClient]
@GenerateMocks([Dio, ResponseResultMapper, GetRequest, PostRequest, ResponseModelMapper, Response, Success])
void main() {
  const String path = '/path';
  const Map<String, String> requestParams = {'key': 'value'};
  const Map<String, String> headers = {'key': 'value'};

  late MockDio clientMock;
  late MockResponseResultMapper responseResultMapperMock;
  late MockResponseModelMapper<Object> responseModelMapperMock;


  late MockGetRequest<Object> getRequestMock;
  late MockPostRequest<Object> postRequestMock;


  final MockResponse responseMock = MockResponse();
  final MockSuccess<Object, NetworkError> successMock = MockSuccess();
  provideDummy<Result<Object, NetworkError>>(successMock);

  late ApiClient apiClient;

  setUp(() {
    void mockRequest(ApiRequest<Object> request) {
      when(request.path).thenReturn(path);
      when(request.params).thenReturn(requestParams);
      when(request.headers).thenReturn(headers);
      when(request.dataModelMapper).thenReturn(responseModelMapperMock);
    }

    clientMock = MockDio();
    responseResultMapperMock = MockResponseResultMapper();
    responseModelMapperMock = MockResponseModelMapper();
    getRequestMock = MockGetRequest<Object>();
    postRequestMock = MockPostRequest<Object>();

    apiClient = ApiClient(clientMock, responseResultMapperMock);

    mockRequest(getRequestMock);
    mockRequest(postRequestMock);

    when(clientMock.get(any, queryParameters: anyNamed("queryParameters"), options: anyNamed("options"))).thenAnswer((_) async => responseMock);
    when(clientMock.post(any, data: anyNamed("data"), options: anyNamed("options"))).thenAnswer((_) async => responseMock);
    when(responseResultMapperMock.call(responseMock, responseModelMapperMock)).thenReturn(successMock);
  });

  void verifyHttpCallOrder(ApiRequest apiRequestMock, Function() httpClientCall) {
    verifyInOrder([
      apiRequestMock.headers,
      apiRequestMock.path,
      apiRequestMock.params,
      httpClientCall(),
      apiRequestMock.dataModelMapper,
      responseResultMapperMock(responseMock, responseModelMapperMock)
    ]);
  }

  test('Given api client when execute GET request then all necessary instances are invoked only once', () async {
    await apiClient.execute(getRequestMock);

    clientGetCall() => clientMock.get(path, queryParameters: requestParams, options: anyNamed("options"));
    verifyHttpCallOrder(getRequestMock, clientGetCall);
  });

  test('Given api client when execute POST request then all necessary instances are invoked only once', () async {
    await apiClient.execute(postRequestMock);

    clientPostCall() => clientMock.post(path, data: requestParams, options: anyNamed("options"));
    verifyHttpCallOrder(postRequestMock, clientPostCall);
  });

  test('Given api client when execute GET request then POST method not called', () async {
    await apiClient.execute(getRequestMock);

    verifyNever(clientMock.post(any, data: anyNamed("data"), options: anyNamed("options")));
  });

  test('Given api client when execute POST request then GET method not called', () async {
    await apiClient.execute(postRequestMock);

    verifyNever(clientMock.get(any, queryParameters: anyNamed("queryParameters"), options: anyNamed("options")));
  });

  test('Given api client when execute then result received from result mapper', () async {
    final Result<Object, NetworkError> actualResult = await apiClient.execute(getRequestMock);

    expect(actualResult, successMock);
  });
}