import 'package:currency/core-network/http_service_client.dart';
import 'package:currency/core-network/request/api_request.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-network/response/response_result_mapper.dart';
import 'package:currency/core-utils/result.dart';
import 'package:dio/dio.dart';

///An HTTP client wrapper for [Dio] client
class ApiClient implements HttpServiceClient {
  final Dio _httpClient;
  final ResponseResultMapper _responseResultMapper;

  ApiClient(this._httpClient, this._responseResultMapper);

  @override
  Future<Result<T, NetworkError>> execute<T>(ApiRequest<T> request) async {
    Response response = await switch(request) {
      GetRequest() => _get(request),
      PostRequest() => _post(request)
    };

    return _responseResultMapper(response, request.dataModelMapper);
  }

  Future<Response> _get<T>(GetRequest<T> request) {
    Options header = Options(headers: request.headers);
    return _httpClient.get(request.path, queryParameters: request.params, options: header);
  }

  Future<Response> _post<T>(PostRequest<T> request) {
    // TODO Extend the logic with different body types
    Options header = Options(headers: request.headers);
    return _httpClient.post(request.path, data: request.params, options: header);
  }
}