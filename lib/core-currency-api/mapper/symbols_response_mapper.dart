import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-network/response/json_model_mapper.dart';
import 'package:currency/core-utils/json.dart';

///A class to convert a JSON data from [String] to [SymbolsResponse] object
final class SymbolsResponseMapper implements JsonModelMapper<SymbolsResponse?> {

  final Json _json;

  SymbolsResponseMapper(this._json);

  @override
  SymbolsResponse? call(String json) {
    Map<String, dynamic>? jsonMap = _json.decode(json);
    return jsonMap != null ? SymbolsResponse.fromJson(jsonMap) : null;
  }
}