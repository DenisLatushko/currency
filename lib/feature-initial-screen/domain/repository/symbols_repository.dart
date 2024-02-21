import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';

///A repository which provides all necessary information about currency symbols
abstract interface class SymbolsRepository {
  Future<Result<SymbolsDomainModel, NetworkError>> fetchSymbols();
}
