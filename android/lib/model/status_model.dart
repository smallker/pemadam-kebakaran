import 'dart:convert';

class StatusModel {
  StatusModel({
    this.temperature,
    this.smoke,
    this.status,
    this.fire,
  });

  int temperature;
  String smoke;
  String status;
  String fire;
  factory StatusModel.fromJson(String str) =>
      StatusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusModel.fromMap(Map<dynamic, dynamic> json) => StatusModel(
      temperature: json["temperature"] == null ? 0 : json["temperature"],
      smoke: json["smoke"] == null ? 'N/A' : json["smoke"],
      status: json["status"] == null ? 'N/A' : json["status"],
      fire: json["fire"] == null ? 'N/A' : json["fire"]);

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "smoke": smoke,
        "status": status,
        "fire": fire
      };
}
