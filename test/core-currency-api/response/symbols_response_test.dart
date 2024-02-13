import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/file_utils.dart';
import '../const.dart';

///Tests to check the behaviour of [SymbolsResponse].fromJson(json)
void main() {
  test('Given symbols JSON text when parse from JSON then object has all values', () {
    final Map<String, dynamic> json = readJsonFromFile(symbolsFilePath);

    SymbolsResponse actualResponse = SymbolsResponse.fromJson(json);

    expect(actualResponse, fullDataSymbolResponse);
  });

  test('Given symbols JSON text with empty data when parse from JSON then object has no any values', () {
    final Map<String, dynamic> json = readJsonFromFile(symbolsEmptyDataFilePath);
    SymbolsResponse expectedResponse = const SymbolsResponse(success: null, symbols: null);

    SymbolsResponse actualResponse = SymbolsResponse.fromJson(json);

    expect(actualResponse, expectedResponse);
  });

  test('Given empty symbols JSON text when parse from JSON then symbols map is empty', () {
    final Map<String, dynamic> json = readJsonFromFile(symbolsEmptyMapFilePath);
    SymbolsResponse expectedResponse = const SymbolsResponse(success: null, symbols: {});

    SymbolsResponse actualResponse = SymbolsResponse.fromJson(json);

    expect(actualResponse, expectedResponse);
  });
}
