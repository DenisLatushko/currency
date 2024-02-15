import 'package:currency/core-currency-api/response/error_response.dart';
import 'package:currency/core-network/response/json_model_mapper.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';
import 'package:currency/core-utils/json.dart';
import 'package:currency/core-utils/result.dart';

class ResponseJsonModelMapper<S> implements ResponseModelMapper<S>{

  final Json _json;
  final JsonModelMapper<S> _successResponseMapper;
  final JsonModelMapper<ErrorResponse> _errorResponseMapper;

  ResponseJsonModelMapper(this._json, this._successResponseMapper, this._errorResponseMapper);

  @override
  Result<S, NetworkError> call(dynamic jsonData) {
    Map<String, dynamic>? jsonMap = jsonData != null ? _json.decode(jsonData) : null;

    if(jsonMap == null) {
      return Error<S, NetworkError>(NoDataParsed());
    } else if(_isErrorResponse(jsonMap)) {
      ErrorResponse errorResponse = _errorResponseMapper(jsonMap);
      return Error(ApiError(errorCode: errorResponse.code, message: errorResponse.info ?? "" ));
    } else {
      return Success(_successResponseMapper(jsonMap));
    }
  }

  bool _isErrorResponse(Map<String, dynamic> map) => (map.containsKey('success') && map['success'] == false) || map.containsKey('error');
}