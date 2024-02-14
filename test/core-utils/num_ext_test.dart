import 'package:currency/core-utils/num_ext.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

///Tests to check extension functions for [num] data type
void main() {
  const rangeStart = 0;
  const rangeEnd = 100;

  const outRangeLeft = rangeStart - 1;
  const outRangeRight = rangeEnd + 1;

  const inRangeLeft = rangeStart + 1;
  const inRangeRight = rangeEnd - 1;

  parameterizedTest(
      'given number when change is it im range then bool result returned',
      [
        [rangeStart, true, true, true],
        [rangeStart, true, false, true],
        [rangeStart, false, false, false],
        [rangeStart, false, true, false],

        [rangeEnd, true, true, true],
        [rangeEnd, true, false, false],
        [rangeEnd, false, false, false],
        [rangeEnd, false, true, true],

        [outRangeLeft, true, true, false],
        [outRangeLeft, true, false, false],
        [outRangeLeft, false, false, false],
        [outRangeLeft, false, true, false],

        [outRangeRight, true, true, false],
        [outRangeRight, true, false, false],
        [outRangeRight, false, false, false],
        [outRangeRight, false, true, false],

        [inRangeLeft, true, true, true],
        [inRangeLeft, true, false, true],
        [inRangeLeft, false, false, true],
        [inRangeLeft, false, true, true],

        [inRangeRight, true, true, true],
        [inRangeRight, true, false, true],
        [inRangeRight, false, false, true],
        [inRangeRight, false, true, true]
      ],
      p4((num value, bool incLeft, bool incRight, bool expectedResult){
        bool actualResult = value.isBetween(rangeStart, rangeEnd, incLeft, incRight);

        expect(actualResult, expectedResult);
      }));
}