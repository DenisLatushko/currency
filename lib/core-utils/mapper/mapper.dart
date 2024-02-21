abstract interface class Mapper1<T, P> {
  T call(P params);
}

abstract interface class Mapper2<T, P1, P2> {
  T call(P1 param1, P2 param2);
}
