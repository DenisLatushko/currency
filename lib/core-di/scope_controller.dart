import 'dc_module.dart';

///A basic type to control a dependency lifetime scope
abstract interface class ScopeController {

  ///Add new scope by [scopeName]. If new dependencies must be initialized in this scope
  ///immediately then provide [modules]
  void addScope(String scopeName, [List<DcModule> modules = const []]);

  ///Remove scope by [scopeName]
  void removeScope(String scopeName);

  ///Remove the latest scope
  void popScope();
}