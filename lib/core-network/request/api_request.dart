import 'package:currency/core-network/cache/cache_settings.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';

/// A basic class for API request
sealed class ApiRequest<T> {
  final String path;
  final Map<String, String> headers;
  final Map<String, String> params;
  final ResponseModelMapper<T> dataModelMapper;
  final CacheSettings? cacheSettings;

  ApiRequest(this.path, this.headers, this.params, this.dataModelMapper, this.cacheSettings);
}

///A basic class for GET http method
class GetRequest<T> extends ApiRequest<T> {
  GetRequest(String path, ResponseModelMapper<T> dataModelMapper,
      {Map<String, String> headers = const {}, Map<String, String> params = const {}, CacheSettings? cacheSettings})
      : super(path, headers, params, dataModelMapper, cacheSettings);
}

///A basic class for POST http method
class PostRequest<T> extends ApiRequest<T> {
  PostRequest(String path, ResponseModelMapper<T> dataModelMapper,
      {Map<String, String> headers = const {}, Map<String, String> params = const {}, CacheSettings? cacheSettings})
      : super(path, headers, params, dataModelMapper, cacheSettings);
}
