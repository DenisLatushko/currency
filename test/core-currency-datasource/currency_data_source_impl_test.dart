import 'package:currency/core-currency-api/request/symbols_request.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-currency-datasource/currency_data_source_impl.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-currency-datasource/model/symbols_data_model_mapper.dart';
import 'package:currency/core-di/lazy_provider.dart';
import 'package:currency/core-network/http_service_client.dart';
import 'package:currency/core-network/response/network_error.dart';
import 'package:currency/core-utils/directory_provider.dart';
import 'package:currency/core-utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/expect.dart';
import '../utils/function.dart';

@GenerateNiceMocks([
  MockSpec<HttpServiceClient>(),
  MockSpec<LazyProvider>(),
  MockSpec<SymbolsDataModelMapper>(),
  MockSpec<Function1>(),
  MockSpec<Success>(),
  MockSpec<DirectoryProvider>(),
])
import 'currency_data_source_impl_test.mocks.dart';

///Tests for [CurrencyDataSourceImpl]
void main() {
  const SymbolsDataModel symbolsDataModel = SymbolsDataModel({});
  const SymbolsResponse symbolsResponse = SymbolsResponse(success: true, symbols: {});
  final SymbolsRequest symbolsRequest = SymbolsRequest(MockFunction1<Result<SymbolsResponse, NetworkError>, dynamic>(), MockDirectoryProvider());

  late MockHttpServiceClient apiClientMock;
  late MockSymbolsDataModelMapper symbolsDataModelMapperMock;
  late MockLazyProvider<SymbolsRequest> symbolsRequestLazyMock;
  late MockLazyProvider<MockSymbolsDataModelMapper> symbolsDataModelMapperLazyMock;

  late CurrencyDataSourceImpl dataSource;

  provideDummy(symbolsRequest);
  provideDummy(symbolsDataModel);
  provideDummy<MockSymbolsDataModelMapper>(MockSymbolsDataModelMapper());

  setUp(() {
    apiClientMock = MockHttpServiceClient();
    symbolsDataModelMapperMock = MockSymbolsDataModelMapper();
    symbolsRequestLazyMock = MockLazyProvider<SymbolsRequest>();
    symbolsDataModelMapperLazyMock = MockLazyProvider<MockSymbolsDataModelMapper>();

    dataSource = CurrencyDataSourceImpl(apiClientMock, symbolsRequestLazyMock, symbolsDataModelMapperLazyMock);

    when(symbolsRequestLazyMock.get()).thenReturn(symbolsRequest);
    when(symbolsDataModelMapperLazyMock.get()).thenReturn(symbolsDataModelMapperMock);
    when(symbolsDataModelMapperMock.call(any)).thenReturn(symbolsDataModel);
  });

  test('Given datasource when success fetch for symbols then success result returned', () async {
    final Success<SymbolsResponse, NetworkError> successResponse = Success<SymbolsResponse, NetworkError>(symbolsResponse);
    provideDummy<Result<SymbolsResponse, NetworkError>>(successResponse);

    when(apiClientMock.execute<SymbolsResponse>(any)).thenAnswer((_) async => successResponse);

    Result<SymbolsDataModel, NetworkError> actualResult = await dataSource.fetchSupportedSymbols();

    expect(actualResult.asSuccess().data, symbolsDataModel);
  });

  test('Given datasource when fetch for symbols fail then error result returned', () async {
    final Error<SymbolsResponse, NetworkError> errorResponse = Error<SymbolsResponse, NetworkError>(NoDataParsed());
    provideDummy<Result<SymbolsResponse, NetworkError>>(errorResponse);

    when(apiClientMock.execute<SymbolsResponse>(any)).thenAnswer((_) async => errorResponse);

    Result<SymbolsDataModel, NetworkError> actualResult = await dataSource.fetchSupportedSymbols();

    expectTrue(actualResult.asError().error! is NoDataParsed);
  });

  test('Given datasource when success fetch for symbols then all instances invoked', () async {
    final Success<SymbolsResponse, NetworkError> successResponse = Success<SymbolsResponse, NetworkError>(symbolsResponse);
    provideDummy<Result<SymbolsResponse, NetworkError>>(successResponse);

    when(apiClientMock.execute<SymbolsResponse>(any)).thenAnswer((_) async => successResponse);

    await dataSource.fetchSupportedSymbols();

    verifyInOrder([
      symbolsRequestLazyMock.get(),
      apiClientMock.execute(symbolsRequest),
      symbolsDataModelMapperLazyMock.get(),
      symbolsDataModelMapperMock.call(symbolsResponse)
    ]);
  });

  test('Given datasource when fetch for symbols fail then not all instances invoked', () async {
    final Error<SymbolsResponse, NetworkError> errorResponse = Error<SymbolsResponse, NetworkError>(NoDataParsed());
    provideDummy<Result<SymbolsResponse, NetworkError>>(errorResponse);

    when(apiClientMock.execute<SymbolsResponse>(any)).thenAnswer((_) async => errorResponse);

    await dataSource.fetchSupportedSymbols();

    verifyNever(symbolsDataModelMapperMock.call(any));
    verifyInOrder([symbolsRequestLazyMock.get(), apiClientMock.execute(symbolsRequest)]);
  });

}
