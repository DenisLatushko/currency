import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/registration_controller.dart';

/// A basic type for classes responsible for dependency initialization
abstract interface class DcModule {

  ///Initialize dependency.
  ///- [dp] provides necessary dependency if needed
  ///- [rc] to register new dependency
  initModule(DependencyProvider dp, RegistrationController rc);
}