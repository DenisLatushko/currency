import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/lazy_provider.dart';

///A basic type for [DC] which offers a methods to request necessary dependency
abstract interface class DependencyProvider {

  ///Get necessary dependency. If there are more then one instance of one type
  ///objects then use [named] to receive the required object
  T get<T extends Object>([String? named]);

  ///Get necessary dependency lazily. If there are more then one instance of one type
  ///objects then use [named] to receive the required object
  LazyProvider<T> getLazy<T extends Object>([String? named]);

  ///Invoke other [modules] if needed
  void initModule([List<DcModule> modules = const []]);
}
