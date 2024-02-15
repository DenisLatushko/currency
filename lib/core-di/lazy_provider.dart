class LazyProvider<T> {
  final T Function() _onCreate;

  LazyProvider(this._onCreate);

  T get() => _onCreate.call();
}