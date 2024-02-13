import 'package:currency/core-network/request/http_method.dart';

import '../response/json_model_mapper.dart';

/// A basic class for API request
sealed class ApiRequest<T> {
  final HttpMethod method;
  final String path;
  final Map<String, String> headers;
  final Map<String, String> params;
  final JsonModelMapper<T> dataModelMapper;

  ApiRequest(this.method, this.path, this.headers, this.params, this.dataModelMapper);
}

///A basic class for GET http method
class GetRequest<T> extends ApiRequest<T> {
  GetRequest(String path, JsonModelMapper<T> dataModelMapper,
      [Map<String, String> headers = const {}, Map<String, String> params = const {}])
      : super(HttpMethod.get, path, headers, params, dataModelMapper);
}

///A basic class for POST http method
class PostRequest<T> extends ApiRequest<T> {
  PostRequest(String path, JsonModelMapper<T> dataModelMapper,
      [Map<String, String> headers = const {}, Map<String, String> params = const {}])
      : super(HttpMethod.post, path, headers, params, dataModelMapper);
}
