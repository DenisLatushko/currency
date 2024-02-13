import 'package:currency/core-currency-api/mapper/symbols_response_mapper.dart';
import 'package:currency/core-currency-api/response/symbols_response.dart';
import 'package:currency/core-utils/json.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../utils/expect.dart';
import '../const.dart';
import 'symbols_response_mapper_test.mocks.dart';

///Tests to check [SymbolsResponseMapper]
@GenerateMocks([Json])
void main() {
  late MockJson jsonMock;
  late SymbolsResponseMapper mapper;

  late Map<String, dynamic>? jsonMap = {
    "success": true,
    "symbols": {"BGN": "Bulgarian Lev", "ALL": "Albanian Lek"}
  };

  setUp(() {
    jsonMock = MockJson();
    mapper = SymbolsResponseMapper(jsonMock);
  });

  test("Given valid JSON text data when call mapper then value returned", () {
    when(jsonMock.decode(any)).thenReturn(jsonMap);

    SymbolsResponse? actualResult = mapper("");

    expect(actualResult, fullDataSymbolResponse);
  });

  test("Given non-valid JSON text data when call mapper then returned value is NULL", () {
    when(jsonMock.decode(any)).thenReturn(null);

    SymbolsResponse? actualResult = mapper("");

    expectTrue(actualResult == null);
  });
}
