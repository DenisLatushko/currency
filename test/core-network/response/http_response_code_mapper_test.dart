import 'package:currency/core-network/response/http_response_code_mapper.dart';
import 'package:currency/core-network/response/http_response_code_type.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

///Tests aimed to check the correctness of [HttpResponseCodeMapper] functionality
void main() {
  final HttpResponseCodeMapper httpResponseCodeMapper = HttpResponseCodeMapper();

  final Iterable<dynamic> testParams = [
    [200, HttpResponseCodeType.success],
    [-1, HttpResponseCodeType.unknown],
    [0, HttpResponseCodeType.unknown]
  ];

  parameterizedTest(
    'Given a list of HTTP codes when call mapper then result if mapper object by this code',
    testParams,
    p2((int httpCode, HttpResponseCodeType expectedResult) {
      HttpResponseCodeType actualResult = httpResponseCodeMapper(httpCode);
      expect(actualResult, expectedResult);
    }),
  );
}