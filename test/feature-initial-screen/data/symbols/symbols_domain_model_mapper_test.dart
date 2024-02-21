import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_domain_model_mapper.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:flutter_test/flutter_test.dart';

///Tests for [SymbolsDomainModelMapper]
void main() {
  const Map<String, String> symbolsMap = {"key": "value"};

  const SymbolsDomainModelMapper mapper = SymbolsDomainModelMapper();

  test('Given data model when call mapper then domain model returned', () {
    SymbolsDataModel dataModel = const SymbolsDataModel(symbolsMap);

    SymbolsDomainModel domainModel = mapper(dataModel);

    expect(domainModel.symbols, dataModel.symbols);
  });
}
