// ignore_for_file: cascade_invocations

import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/core-di/dc_module.dart';
import 'package:currency/core-di/dependency_provider.dart';
import 'package:currency/core-di/registration_controller.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_domain_model_mapper.dart';
import 'package:currency/feature-initial-screen/data/symbols/symbols_repository_impl.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';
import 'package:currency/feature-initial-screen/domain/repository/symbols_repository.dart';

const _symbolsDomainModelMapper = 'SymbolsDomainModelMapper';

final class InitialScreenModule implements DcModule {
  @override
  void initModule(DependencyProvider dp, RegistrationController rc) {
    rc.factory<SymbolsDomainModel Function(SymbolsDataModel)>(() => const SymbolsDomainModelMapper());
    rc.lazyFactory(() => dp.get<SymbolsDomainModel Function(SymbolsDataModel)>(_symbolsDomainModelMapper));
    rc.factory<SymbolsRepository>(() => SymbolsRepositoryImpl(dp.get(), dp.get(_symbolsDomainModelMapper)));
  }
}
