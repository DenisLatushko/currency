import 'package:currency/core-currency-datasource/model/symbols_data_model.dart';
import 'package:currency/feature-initial-screen/domain/model/symbols_domain_model.dart';

///A domain model mapper to convert [SymbolsDataModel] to [SymbolsDomainModel]
class SymbolsDomainModelMapper {

  const SymbolsDomainModelMapper();

  SymbolsDomainModel call(SymbolsDataModel dataModel) => SymbolsDomainModel(dataModel.symbols);
}
