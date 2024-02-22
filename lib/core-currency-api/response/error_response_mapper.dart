import 'package:currency/core-currency-api/response/error_response.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';

///A class to convert a JSON data from [String] to [SymbolsResponse] object
final class ErrorResponseMapper {

  const ErrorResponseMapper();

  ErrorResponse call(Map<String, dynamic> jsonData) => ErrorResponse.fromJson(jsonData);
}
