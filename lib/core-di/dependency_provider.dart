///A basic type for [DC] which offers a methods to request necessary dependency
abstract interface class DependencyProvider {

  ///Get necessary dependency. If there are more then one instance of one type
  ///objects then use [named] to receive the required object
  T get<T>(String? named);
}