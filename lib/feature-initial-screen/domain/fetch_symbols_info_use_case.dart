import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:currency/feature-initial-screen/domain/repository/symbols_repository.dart';

///Use case to compute the information about symbols
final class FetchSymbolsInfoUseCase {

  final SymbolsRepository _symbolsRepository;

  FetchSymbolsInfoUseCase(this._symbolsRepository);

  Future<Result<SymbolsDomainModel, NetworkError>> call() => _symbolsRepository.fetchSymbols();
}
