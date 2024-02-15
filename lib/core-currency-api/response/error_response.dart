import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

///A model which presents Error Response data received from API.
///See https://fixer.io/documentation#errors
@JsonSerializable(createToJson: false)
final class ErrorResponse extends Equatable {
  final int code;
  final String? info;

  const ErrorResponse({required this.code, required this.info});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  @override
  List<Object?> get props => [code, info];
}
