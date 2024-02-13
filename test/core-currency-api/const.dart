import 'package:currency/core-currency-api/response/symbols_response.dart';

///Test assets files
const symbolsFilePath = "test_assets/api/response/symbols.json";
const symbolsEmptyDataFilePath = "test_assets/api/response/symbols_empty_data.json";
const symbolsEmptyMapFilePath = "test_assets/api/response/symbols_empty_map.json";

const SymbolsResponse fullDataSymbolResponse = SymbolsResponse(
    success: true,
    symbols: {"BGN": "Bulgarian Lev", "ALL": "Albanian Lek"}
);
