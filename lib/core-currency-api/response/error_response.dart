import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

///A model which presents Error Response data received from API.
///See https://fixer.io/documentation#errors
@JsonSerializable(createToJson: false)
final class ErrorResponse extends Equatable {
  @JsonKey(name: "success") final bool success;
  @JsonKey(name: "error") final ErrorDataResponse? error;

  const ErrorResponse({required this.success, required this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  @override
  List<Object?> get props => [success, error];
}

@JsonSerializable(createToJson: false)
final class ErrorDataResponse extends Equatable {
  final int code;
  final String? info;

  const ErrorDataResponse({required this.code, required this.info});

  factory ErrorDataResponse.fromJson(Map<String, dynamic> json) => _$ErrorDataResponseFromJson(json);

  @override
  List<Object?> get props => [code, info];
}
