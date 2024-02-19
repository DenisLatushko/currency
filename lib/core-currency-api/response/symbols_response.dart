import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'symbols_response.g.dart';

///A model which presents Symbols Response data received from API.
///See https://fixer.io/documentation -> Endpoints -> Supported Symbols Endpoint
@JsonSerializable(createToJson: false)
class SymbolsResponse extends Equatable {
  @JsonKey(name: "success") final bool success;
  @JsonKey(name: "symbols") final Map<String, String>? symbols;

  const SymbolsResponse({required this.success, required this.symbols});

  factory SymbolsResponse.fromJson(Map<String, dynamic> json) => _$SymbolsResponseFromJson(json);

  @override
  List<Object?> get props => [symbols];
}
