abstract interface class Function1<T, P> {
  T call(P param);
}

abstract interface class FunctionNoParams<T> {
  T call();
}
