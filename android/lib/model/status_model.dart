import 'dart:convert';

class StatusModel {
  StatusModel({
    this.temperature,
    this.smoke,
    this.status,
  });

  int temperature;
  String smoke;
  String status;

  factory StatusModel.fromJson(String str) =>
      StatusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusModel.fromMap(Map<dynamic, dynamic> json) => StatusModel(
        temperature: json["temperature"],
        smoke: json["smoke"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "smoke": smoke,
        "status": status,
      };
}
