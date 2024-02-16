import 'package:currency/core-network/request/api_request.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';

///A Basic type for any HTTP client wrapper
abstract interface class HttpServiceClient {
  Future<Result<T, NetworkError>> execute<T>(ApiRequest<T> request);
}
