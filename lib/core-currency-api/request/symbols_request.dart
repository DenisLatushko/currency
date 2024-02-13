import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-network/request/api_request.dart';
import '../../../core-network/response/json_model_mapper.dart';

///An API get request to receive all supported currencies names
///See https://fixer.io/documentation -> Endpoints -> Supported Symbols Endpoint
final class SymbolsRequest extends GetRequest<SymbolsResponse> {
  SymbolsRequest(JsonModelMapper<SymbolsResponse> dataModelMapper) : super("/api/symbols", dataModelMapper);
}