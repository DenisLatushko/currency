import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/core-di/scope_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'dc_module.dart';
import 'dependency_provider.dart';

///A Singleton dependency graph manager. Basically this is a wrapper above the [GetIt] service locator.
///The functionality is divided by the following interfaces:
///- [DependencyProvider] - only to provide dependency
///- [RegistrationController] - an internal interface to register the dependency(ies) in the graph. Is is being used
///in pair with [DcModule] instance which contains all the dependency initialization logic
///- [ScopeController] - only to control the current dependency scope
class DC implements DependencyProvider, RegistrationController, ScopeController {
  static final DC _instance = DC._newInstance(GetIt.instance);

  static DependencyProvider getDependencyProvider() => _instance;

  static ScopeController getScopeController() => _instance;

  final GetIt _getItInstance;

  DC._newInstance(GetIt getIt) : _getItInstance = getIt;

  @visibleForTesting
  factory DC.withClient(GetIt getItInstance) {
    return DC._newInstance(getItInstance);
  }

  @override
  T get<T>(String? named) => named != null ? _getItInstance.get(instanceName: named) : _getItInstance.get();

  @override
  void factory<T extends Object>(T Function() factory, [String? named]) {
    _getItInstance.registerFactory<T>(factory, instanceName: named);
  }

  @override
  void singleton<T extends Object>(T instance, [String? named]) {
    _getItInstance.registerSingleton(instance, instanceName: named);
  }

  @override
  void popScope() {
    _getItInstance.popScope();
  }

  @override
  void removeScope(String scopeName) {
    _getItInstance.dropScope(scopeName);
  }

  @override
  void addScope(String name, [List<DcModule> modules = const []]) {
    _getItInstance.pushNewScope(init: (_) => initModule(modules), scopeName: name, isFinal: false);
  }

  @override
  void initModule([List<DcModule> modules = const []]) {
    registerDependencies(modules);
  }

  void registerDependencies(List<DcModule> modules) {
    // ignore_for_file: avoid_function_literals_in_foreach_calls
    modules.forEach((module) => module.initModule(this, this));
  }
}
