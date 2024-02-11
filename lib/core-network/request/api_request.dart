import 'package:currency/core-network/request/http_method.dart';
import '../response/json_model_mapper.dart';

/// A basic class for API request
sealed class ApiRequest<T> {
  final HttpMethod method;
  final String domain;
  final String path;
  final Map<String, String> headers;
  final Map<String, String> params;
  final JsonModelMapper<T> dataModelMapper;

  ApiRequest(this.method, this.domain, this.path, this.dataModelMapper, this.headers, this.params);
}

///A basic class for GET http method
class GetRequest<T> extends ApiRequest<T> {
  GetRequest(String domain, String path, JsonModelMapper<T> dataModelMapper, [Map<String, String> headers = const {},
    Map<String, String> params = const {}]) : super (HttpMethod.get, domain, path, dataModelMapper, headers, params);
}

///A basic class for POST http method
class PostRequest<T> extends ApiRequest<T> {
  PostRequest(String domain, String path, JsonModelMapper<T> dataModelMapper, [Map<String, String> headers = const {},
    Map<String, String> params = const {}]) : super (HttpMethod.get, domain, path, dataModelMapper, headers, params);
}