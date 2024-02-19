import 'package:equatable/equatable.dart';

///A data model which presents a map of supported currencies
class SymbolsDataModel extends Equatable {
  final Map<String, String> symbols;

  const SymbolsDataModel(this.symbols);

  @override
  List<Object?> get props => [symbols];
}
