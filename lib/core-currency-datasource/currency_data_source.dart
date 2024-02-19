import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';

///A basic interface for currency data source
abstract interface class CurrencyDataSource {

  ///Fetch all supported currency symbols
  Future<Result<SymbolsDataModel, NetworkError>> fetchSupportedSymbols();
}
