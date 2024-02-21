import 'package:equatable/equatable.dart';

///A domain model for initial screen feature which presents all supported currencies with its names
class SymbolsDomainModel extends Equatable {
  final Map<String, String> symbols;

  const SymbolsDomainModel(this.symbols);

  @override
  List<Object?> get props => [symbols];
}
