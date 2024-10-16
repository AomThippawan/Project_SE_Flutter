// To parse this JSON data, do
//
//     final applyModel = applyModelFromJson(jsonString);

import 'dart:convert';

ApplyModel applyModelFromJson(String str) =>
    ApplyModel.fromJson(json.decode(str));

String applyModelToJson(ApplyModel data) => json.encode(data.toJson());

class ApplyModel {
  String studentName;
  String studentEmail;
  String id;

  ApplyModel({
    required this.studentName,
    required this.studentEmail,
    required this.id,
  });

  factory ApplyModel.fromJson(Map<String, dynamic> json) => ApplyModel(
        studentName: json["StudentName"],
        studentEmail: json["StudentEmail"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "StudentName": studentName,
        "StudentEmail": studentEmail,
        "_id": id,
      };
}
