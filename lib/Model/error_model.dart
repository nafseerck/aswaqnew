import 'dart:convert';

ErrorMessage errorMessageFromJson(String str) => ErrorMessage.fromJson(json.decode(str));

String errorMessageToJson(ErrorMessage data) => json.encode(data.toJson());

class ErrorMessage {
  ErrorMessage({
    this.message,
  });

  String message;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
