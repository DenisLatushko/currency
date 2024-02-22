import 'package:currency/core-currency-api/request/symbols_request.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-datasource/currency_data_source.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-di/lazy_provider.dart';
import 'package:currency/core-network/http_service_client.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';

///A basic interface for currency data source
class CurrencyDataSourceImpl implements CurrencyDataSource {

  final HttpServiceClient _apiClient;
  final LazyProvider<SymbolsRequest> _symbolsRequest;
  final LazyProvider<SymbolsDataModel Function(SymbolsResponse)> _symbolsDataModelMapper;

  CurrencyDataSourceImpl(this._apiClient, this._symbolsRequest, this._symbolsDataModelMapper);

  @override
  Future<Result<SymbolsDataModel, NetworkError>> fetchSupportedSymbols() async {
    Result<SymbolsResponse, NetworkError> responseResult = await _apiClient.execute(_symbolsRequest.get());
    return responseResult.map(_symbolsDataModelMapper.get());
  }
}
