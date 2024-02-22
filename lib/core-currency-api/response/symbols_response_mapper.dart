import 'package:currency/core-currency-api/response/symbols_response.dart';

///A class to convert a JSON data from [String] to [SymbolsResponse] object
final class SymbolsResponseMapper {

  const SymbolsResponseMapper();

  SymbolsResponse call(Map<String, dynamic> jsonData) => SymbolsResponse.fromJson(jsonData);
}
