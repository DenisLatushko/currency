import 'package:currency/core-utils/json.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core-currency-api/const.dart';
import '../utils/expect.dart';
import '../utils/file_utils.dart';

///Test for [Json] decoder
void main() {
  final Json json = Json();

  test('Given valid JSON text when call decode then object decoded', () {
    String jsonData = readFile(symbolsFilePath);

    dynamic actualResult = json.decode(jsonData);

    expectTrue(actualResult != null);
  });

  test('Given non-valid JSON text when call decode then object is NULL', () {
    dynamic actualResult = json.decode("");

    expectTrue(actualResult == null);
  });
}