// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  String stskill;
  String stability;
  String stworktime;
  String id;

  PostModel({
    required this.stskill,
    required this.stability,
    required this.stworktime,
    required this.id,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        stskill: json["stskill"] ?? 'No skill available',
        stability: json["stability"] ?? 'No stability info',
        stworktime: json["stworktime"] ?? 'No work time info',
        id: json["_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stskill": stskill,
        "stability": stability,
        "stworktime": stworktime,
        "_id": id,
      };
}
