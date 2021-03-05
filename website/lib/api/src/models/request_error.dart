import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestError extends Equatable {
  final String status;
  final int statusCode;
  final String message;
  RequestError({
    this.status,
    this.statusCode,
    this.message,
  });

  factory RequestError.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RequestError(
      status: map['status'],
      statusCode: map['statusCode'],
      message: map['message'],
    );
  }

  factory RequestError.fromJson(String source) =>
      RequestError.fromMap(json.decode(source));

  @override
  List<Object> get props => [status, statusCode, message];
}
