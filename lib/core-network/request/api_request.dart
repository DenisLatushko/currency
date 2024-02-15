import 'package:currency/core-network/response/response_model_mapper.dart';

/// A basic class for API request
sealed class ApiRequest<T> {
  final String path;
  final Map<String, String> headers;
  final Map<String, String> params;
  final ResponseModelMapper<T> dataModelMapper;

  ApiRequest(this.path, this.headers, this.params, this.dataModelMapper);
}

///A basic class for GET http method
class GetRequest<T> extends ApiRequest<T> {
  GetRequest(String path, ResponseModelMapper<T> dataModelMapper,
      [Map<String, String> headers = const {}, Map<String, String> params = const {}])
      : super(path, headers, params, dataModelMapper);
}

///A basic class for POST http method
class PostRequest<T> extends ApiRequest<T> {
  PostRequest(String path, ResponseModelMapper<T> dataModelMapper,
      [Map<String, String> headers = const {}, Map<String, String> params = const {}])
      : super(path, headers, params, dataModelMapper);
}
