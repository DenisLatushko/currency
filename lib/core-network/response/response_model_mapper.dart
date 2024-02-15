import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';

abstract interface class ResponseModelMapper<S> {
  Result<S, NetworkError> call(dynamic jsonData);
}