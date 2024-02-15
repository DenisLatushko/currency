import 'package:flutter_test/flutter_test.dart';

void expectTrue(bool actualResult) {
  expect(actualResult, true);
}

void expectNull<T>(T actualResult) {
  expectTrue(actualResult == null);
}