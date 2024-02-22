import 'package:currency/core-currency-datasource/currency_data_source.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-di/lazy_provider.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/result.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_domain_model_mapper.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_repository_impl.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../utils/expect.dart';
import '../../../utils/function.dart';

@GenerateNiceMocks([MockSpec<CurrencyDataSource>(), MockSpec<Function1>(), MockSpec<LazyProvider>()])
import 'symbols_repository_impl_test.mocks.dart';

typedef SymbolsDomainModelMapperFunction = SymbolsDomainModel Function(SymbolsDataModel);

///Tests for [SymbolsRepositoryImpl]
void main() {
  const SymbolsDataModel dataModel = SymbolsDataModel({});
  const SymbolsDomainModel domainModel = SymbolsDomainModel({});
  provideDummy<SymbolsDomainModel>(domainModel);

  late Success<SymbolsDataModel, NetworkError> successData = const Success<SymbolsDataModel, NetworkError>(dataModel);
  late Success<SymbolsDomainModel, NetworkError> successDomain = const Success<SymbolsDomainModel, NetworkError>(domainModel);

  late Error<SymbolsDataModel, NetworkError> errorsData = const Error<SymbolsDataModel, NetworkError>(null);
  late Error<SymbolsDomainModel, NetworkError> errorDomain = const Error<SymbolsDomainModel, NetworkError>(null);

  late MockCurrencyDataSource currencyDataSourceMock;
  late MockFunction1<SymbolsDomainModel, SymbolsDataModel> symbolsDomainModelMapperMock;
  late MockLazyProvider<SymbolsDomainModelMapperFunction> symbolsDomainModelMapperLazyMock;
  late SymbolsRepositoryImpl repository;

  setUp(() {
    currencyDataSourceMock = MockCurrencyDataSource();
    symbolsDomainModelMapperMock = MockFunction1<SymbolsDomainModel, SymbolsDataModel>();
    symbolsDomainModelMapperLazyMock = MockLazyProvider<SymbolsDomainModelMapperFunction>();
    repository = SymbolsRepositoryImpl(currencyDataSourceMock, symbolsDomainModelMapperLazyMock);

    provideDummy<Function1<SymbolsDomainModel, SymbolsDataModel>>(symbolsDomainModelMapperMock);

    when(symbolsDomainModelMapperMock(any)).thenReturn(domainModel);
    when(symbolsDomainModelMapperLazyMock.get()).thenReturn(symbolsDomainModelMapperMock);
  });

  group('Given success fetch', () {
    setUp(() async {
      provideDummy<Result<SymbolsDataModel, NetworkError>>(successData);
      when(currencyDataSourceMock.fetchSupportedSymbols()).thenAnswer((_) async => successData);
    });

    test('Given success fetch for symbols when call repository then return result success', () async {
      Result<SymbolsDomainModel, NetworkError> resultData = await repository.fetchSymbols();

      expectTrue(resultData is Success<SymbolsDomainModel, NetworkError>);
      expect(successDomain, resultData);
    });

    test('Given success fetch for symbols when call repository then all necessary instances invoked', () async {
      await repository.fetchSymbols();

      verifyInOrder([
        currencyDataSourceMock.fetchSupportedSymbols(),
        symbolsDomainModelMapperLazyMock.get(),
        symbolsDomainModelMapperMock.call(dataModel)
      ]);
    });
  });

  group('Given failed fetch', () {
    setUp(() async {
      provideDummy<Result<SymbolsDataModel, NetworkError>>(errorsData);
      when(currencyDataSourceMock.fetchSupportedSymbols()).thenAnswer((_) async => errorsData);
    });

    test('Given failed fetch for symbols when call repository then return result error', () async {
      Result<SymbolsDomainModel, NetworkError> resultData = await repository.fetchSymbols();

      expectTrue(resultData is Error<SymbolsDomainModel, NetworkError>);
      expect(resultData, errorDomain);
    });

    test('Given failed fetch for symbols when call repository then only data source invoked', () async {
      await repository.fetchSymbols();

      verifyNever(symbolsDomainModelMapperMock.call(any));
      verify(currencyDataSourceMock.fetchSupportedSymbols()).called(1);
    });
  });
}
