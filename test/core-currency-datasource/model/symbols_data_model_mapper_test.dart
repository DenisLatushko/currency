import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/expect.dart';

///Tests for [SymbolsDataModelMapper]
void main() {
  const SymbolsDataModelMapper mapper = SymbolsDataModelMapper();

  test('Given symbols response when call mapper then the data model has the same value', () {
    SymbolsResponse response = const SymbolsResponse(success: true, symbols: {"key": "value"});

    SymbolsDataModel actualResult = mapper(response);

    expect(actualResult.symbols, response.symbols);
  });

  test('Given NO symbols response when call mapper then the data model has empty data', () {
    SymbolsResponse response = const SymbolsResponse(success: true, symbols: null);

    SymbolsDataModel actualResult = mapper(response);

    expectTrue(actualResult.symbols.isEmpty);
  });
}
