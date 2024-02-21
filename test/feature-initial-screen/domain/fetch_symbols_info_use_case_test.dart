import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';
import 'package:currency/feature-initial-screen/domain/fetch_symbols_info_use_case.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:currency/feature-initial-screen/domain/repository/symbols_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'fetch_symbols_info_use_case_test.mocks.dart';

///Tests for [FetchSymbolsInfoUseCase]
@GenerateMocks([SymbolsRepository, SymbolsDomainModel])
void main() {
  final SymbolsDomainModel domainModel = MockSymbolsDomainModel();
  final Result<SymbolsDomainModel, NetworkError> symbolsResult = Success<SymbolsDomainModel, NetworkError>(domainModel);
  provideDummy(symbolsResult);

  late MockSymbolsRepository symbolsRepositoryMock;
  late FetchSymbolsInfoUseCase useCase;

  setUp(() async {
    symbolsRepositoryMock = MockSymbolsRepository();
    useCase = FetchSymbolsInfoUseCase(symbolsRepositoryMock);
    when(symbolsRepositoryMock.fetchSymbols()).thenAnswer((_) async => symbolsResult);
  });

  test('Given use case when call it then all instances are invoked', () async {
    await useCase.call();

    verify(symbolsRepositoryMock.fetchSymbols()).called(1);
  });

  test('Given use case when call it then result returned', () async {
    Result<SymbolsDomainModel, NetworkError> domainModel = await useCase.call();

    expect(domainModel, symbolsResult);
  });
}
