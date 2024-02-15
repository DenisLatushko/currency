import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-network/response/json_model_mapper.dart';

///A class to convert a JSON data from [String] to [SymbolsResponse] object
final class SymbolsResponseMapper extends JsonModelMapper<SymbolsResponse> {
  @override
  SymbolsResponse call(Map<String, dynamic> jsonData) => SymbolsResponse.fromJson(jsonData);
}