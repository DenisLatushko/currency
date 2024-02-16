///A class to provide a lazy initialization for object [T]
class LazyProvider<T> {
  final T Function() _onCreate;

  LazyProvider(this._onCreate);

  T get() => _onCreate.call();
}
