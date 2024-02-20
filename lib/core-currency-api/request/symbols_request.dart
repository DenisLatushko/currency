import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-network/cache/cache_settings.dart';
import 'package:currency/core-network/request/api_request.dart';
import 'package:currency/core-network/response/response_model_mapper.dart';
import 'package:currency/core-utils/directory_provider.dart';

///An API get request to receive all supported currencies names
///See https://fixer.io/documentation -> Endpoints -> Supported Symbols Endpoint
final class SymbolsRequest extends GetRequest<SymbolsResponse> {
  SymbolsRequest(
      ResponseModelMapper<SymbolsResponse> dataModelMapper,
      DirectoryProvider cacheDirectoryProvider
  ) : super(
      "/api/symbols",
      dataModelMapper,
      cacheSettings: CacheSettings(CacheRule.forceCache, const Duration(days: 30), cacheDirectoryProvider)
  );
}
