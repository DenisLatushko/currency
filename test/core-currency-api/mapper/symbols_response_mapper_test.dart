import 'package:currency/core-currency-api/response/symbols_response_mapper.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/file_utils.dart';
import '../const.dart';

///Tests to check the behaviour of [SymbolsResponseMapper]
void main() {

  final SymbolsResponseMapper mapper = SymbolsResponseMapper();

  test('Given symbols JSON text when map from JSON then object has all values', () {
    const SymbolsResponse expectedResponse = SymbolsResponse(symbols: {"BGN": "Bulgarian Lev", "ALL": "Albanian Lek"});
    final Map<String, dynamic> json = readJsonFromFile(symbolsFilePath);

    SymbolsResponse actualResponse = mapper(json);

    expect(actualResponse, expectedResponse);
  });

  test('Given symbols JSON text with empty data when map from JSON then object has no any values', () {
    SymbolsResponse expectedResponse = const SymbolsResponse(symbols: null);
    final Map<String, dynamic> json = readJsonFromFile(symbolsEmptyDataFilePath);

    SymbolsResponse actualResponse = mapper(json);

    expect(actualResponse, expectedResponse);
  });

  test('Given empty symbols JSON text when map from JSON then symbols map is empty', () {
    SymbolsResponse expectedResponse = const SymbolsResponse(symbols: {});
    final Map<String, dynamic> json = readJsonFromFile(symbolsEmptyMapFilePath);

    SymbolsResponse actualResponse = mapper(json);

    expect(actualResponse, expectedResponse);
  });
}