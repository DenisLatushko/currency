///Extension functions for [num] type
extension Range on num {
  bool isBetween(num from, num to, {bool incLeft = false, bool incRight = false}) {
    bool isLeft = switch(incLeft) {
      true => from <= this,
      false => from < this
    };

    bool isRight = switch(incRight) {
      true => this <= to,
      false => this < to
    };

    return isLeft && isRight;
  }
}
