// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    this.error,
  });

  ErrorClass? error;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    error: ErrorClass.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error!.toJson(),
  };
}

class ErrorClass {
  ErrorClass({
    this.code,
    this.message,
    this.status,
  });

  int? code;
  String? message;
  String? status;

  factory ErrorClass.fromJson(Map<String, dynamic> json) => ErrorClass(
    code: json["code"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "status": status,
  };
}
