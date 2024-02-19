import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';

///A mapper to convert [SymbolsResponse] to [SymbolsDataModel]
class SymbolsDataModelMapper {

  const SymbolsDataModelMapper();

  SymbolsDataModel call(SymbolsResponse symbolsResponse) => SymbolsDataModel(symbolsResponse.symbols ?? {});
}
