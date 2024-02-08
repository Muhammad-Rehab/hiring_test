
class ErrorModel {
  final String? message;
  final int? code;

  ErrorModel({
    required this.message,
    this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(message: json["message"],code: json["code"]);

  Map<String, dynamic> toJson() => {"message": message,"code":code};
}