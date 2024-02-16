// ignore_for_file: cascade_invocations

import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/core-network/response/response_result_mapper.dart';
import 'package:currency/core-utils/json.dart';

class CoreNetworkDcModule implements DcModule {
  @override
  void initModule(DependencyProvider dp, RegistrationController rc) {
    rc.factory(Json.new);
    rc.factory(ResponseResultMapper.new);
  }
}
