import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'error.freezed.dart';
part 'error.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  const factory ErrorModel({
    required int statusCode,
    required String message,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}
