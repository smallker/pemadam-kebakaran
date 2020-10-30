// To parse this JSON data, do
//
//     final statusModel = statusModelFromMap(jsonString);

import 'dart:convert';

class HistoryModel {
  HistoryModel({
    this.status,
    this.detail,
    this.timestamp,
  });

  String status;
  String detail;
  int timestamp;

  factory HistoryModel.fromJson(String str) =>
      HistoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromMap(Map<dynamic, dynamic> json) => HistoryModel(
        status: json["status"],
        detail: json["detail"],
        timestamp: int.tryParse(json["timestamp"]) * 1000,
      );

  Map<dynamic, dynamic> toMap() => {
        "status": status,
        "detail": detail,
        "timestamp": timestamp,
      };
}
