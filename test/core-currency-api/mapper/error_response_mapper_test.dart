import 'package:currency/core-currency-api/response/error_response_mapper.dart';
import 'package:currency/core-currency-api/response/error_response.dart';
import 'package:test/test.dart';

import '../../utils/file_utils.dart';
import '../const.dart';

///Tests to check the JSON parsing flow to [ErrorResponse] object
void main() {
  late ErrorResponse fullDataResponse = const ErrorResponse(success: false, error: ErrorDataResponse(code: 104, info: "Message"));
  late ErrorResponse emptyInfoResponse = const ErrorResponse(success: false, error: ErrorDataResponse(code: 104, info: null));

  const ErrorResponseMapper mapper = ErrorResponseMapper();

  test('Given error JSON when parse then object has all values', () {
    final Map<String, dynamic> json = readJsonFromFile(errorFilePath);

    ErrorResponse actualResponse = mapper(json);

    expect(actualResponse, fullDataResponse);
  });

  test('Given error JSON with empty info when parse then only code parsed', () {
    final Map<String, dynamic> json = readJsonFromFile(errorNoMessageFilePath);

    ErrorResponse actualResponse = mapper(json);

    expect(actualResponse, emptyInfoResponse);
  });

  test('Given error JSON with no info when parse then only code parsed', () {
    final Map<String, dynamic> json = readJsonFromFile(errorNoMessageFilePath);

    ErrorResponse actualResponse = mapper(json);

    expect(actualResponse, emptyInfoResponse);
  });
}
