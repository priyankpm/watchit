import 'dart:convert';

ResponseItem responseItemFromJson(String str) => ResponseItem.fromJson(json.decode(str));

String responseItemToJson(ResponseItem data) => json.encode(data.toJson());

class ResponseItem {
  ResponseItem({
    this.data,
    this.message,
    this.error,
    this.success = false,
    this.statusCode,
  });

  dynamic data;
  bool success;
  String? message;
  String? error;
  int? statusCode;

  factory ResponseItem.fromJson(Map<String, dynamic> json) => ResponseItem(
    data: json["data"],
    success: json["success"],
    error: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "success": success,
    "message": message,
    "error": error,
  };
}