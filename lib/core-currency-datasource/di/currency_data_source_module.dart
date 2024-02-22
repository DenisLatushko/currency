// ignore_for_file: cascade_invocations

import 'package:currency/core-currency-api/di/core_currency_api_module.dart';
import 'package:currency/core-currency-api/request/symbols_request.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-datasource/currency_data_source.dart';
import 'package:currency/core-currency-datasource/currency_data_source_impl.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model_mapper.dart';
import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/lazy_provider.dart';
import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/core-network/http_service_client.dart';

typedef SymbolsDataModelMapperFunction = SymbolsDataModel Function(SymbolsResponse);

class CurrencyDataSourceModule implements DcModule {
  @override
  void initModule(DependencyProvider dp, RegistrationController rc) {
    rc.factory<LazyProvider<SymbolsDataModelMapperFunction>>(() => LazyProvider(() => const SymbolsDataModelMapper()));

    rc.factory<CurrencyDataSource>(() =>
        CurrencyDataSourceImpl(
            dp.get<HttpServiceClient>(currencyApiClientName),
            dp.get<LazyProvider<SymbolsRequest>>(),
            dp.get<LazyProvider<SymbolsDataModelMapperFunction>>()
        ));
  }
}
