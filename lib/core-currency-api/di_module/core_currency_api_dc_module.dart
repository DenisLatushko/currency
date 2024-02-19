// ignore_for_file: cascade_invocations

import 'package:currency/core-currency-api/currency_api_env.dart';
import 'package:currency/core-currency-api/request/symbols_request.dart';
import 'package:currency/core-currency-api/response/error_response_mapper.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-api/response/symbols_response_mapper.dart';
import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/core-network/api_client.dart';
import 'package:currency/core-network/interceptor/logging_debug_interceptor.dart';
import 'package:currency/core-network/interceptor/request_query_params_interceptor.dart';
import 'package:currency/core-network/response/response_json_model_mapper.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String currencyApiClientName = "CurrencyApiClientName";
const String currencyHttpClientName = "CurrencyHttpClientName";
const String apiKeyParamMapName = "ApiKeyParamMapName";
const String apiKeyInterceptorName = "ApiKeyInterceptorName";
const String symbolsResponseJsonModelMapperName = "SymbolsResponseJsonModelMapper";

class CoreCurrencyApiDcModule implements DcModule {
  @override
  void initModule(DependencyProvider dp, RegistrationController rc) {
    rc.factory(() => {"access_key" : CurrencyApiEnv.apiKey}, apiKeyParamMapName);

    rc.factory(SymbolsResponseMapper.new);

    rc.factory(ErrorResponseMapper.new);

    rc.factory<ResponseModelMapper<SymbolsResponse>>(() => ResponseJsonModelMapper(
        dp.get(),
        dp.get<SymbolsResponseMapper>(),
        dp.get<ErrorResponseMapper>()),
        symbolsResponseJsonModelMapperName
    );

    rc.factory(() => SymbolsRequest(dp.get(symbolsResponseJsonModelMapperName)));

    rc.factory<Interceptor>(() => RequestQueryParamsInterceptor(dp.get(apiKeyParamMapName)), apiKeyInterceptorName);

    rc.factory(() {
      final BaseOptions baseOptions = BaseOptions(
        baseUrl: 'http://data.fixer.io',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      Dio dio = Dio(baseOptions);

      dio.interceptors.add(dp.get(apiKeyInterceptorName));
      if(kDebugMode) dio.interceptors.add(dp.get<LoggingDebugInterceptor>());

      return dio;
    }, currencyHttpClientName);

    rc.singleton(ApiClient(dp.get(currencyHttpClientName), dp.get()), currencyApiClientName);
  }
}
