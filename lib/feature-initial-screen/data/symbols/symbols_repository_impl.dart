import 'package:currency/core-currency-datasource/currency_data_source.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-di/lazy_provider.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_domain_model_mapper.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:currency/feature-initial-screen/domain/repository/symbols_repository.dart';

///An implementation of [SymbolsRepository]
final class SymbolsRepositoryImpl implements SymbolsRepository {

  final CurrencyDataSource _currencyDataSource;
  final LazyProvider<SymbolsDomainModelMapper> _symbolsDomainModelMapper;

  SymbolsRepositoryImpl(this._currencyDataSource, this._symbolsDomainModelMapper);

  @override
  Future<Result<SymbolsDomainModel, NetworkError>> fetchSymbols() async {
    Result<SymbolsDataModel, NetworkError> resultDataModel = await _currencyDataSource.fetchSupportedSymbols();
    return resultDataModel.map<SymbolsDomainModel>(_symbolsDomainModelMapper.get());
  }
}
