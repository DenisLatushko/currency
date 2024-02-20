import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/core-utils/directory_provider.dart';

final class UtilsModule implements DcModule {

  @override
  void initModule(DependencyProvider dp, RegistrationController rc) {
    rc.factory(DirectoryProvider.new);
  }
}
