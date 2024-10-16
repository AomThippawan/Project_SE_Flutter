// To parse this JSON data, do
//
//     final prof = profFromJson(jsonString);

import 'dart:convert';

Prof profFromJson(String str) => Prof.fromJson(json.decode(str));

String profToJson(ProfModel data) => json.encode(data.toJson());

class ProfModel {
  Prof prof;
  String accessToken;
  String refreshToken;

  ProfModel({
    required this.prof,
    required this.accessToken,
    required this.refreshToken,
  });

  factory ProfModel.fromJson(Map<String, dynamic> json) => ProfModel(
        prof: Prof.fromJson(json["prof"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "prof": prof.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class Prof {
  String id;
  String profName;
  String profEmail;
  String profUsername;
  String profPhone;
  String profPassword;
  String profFaculty;
  String role;

  Prof({
    required this.id,
    required this.profName,
    required this.profEmail,
    required this.profUsername,
    required this.profPhone,
    required this.profPassword,
    required this.profFaculty,
    required this.role,
  });

  factory Prof.fromJson(Map<String, dynamic> json) => Prof(
        id: json["_id"],
        profName: json["profName"],
        profEmail: json["profEmail"],
        profUsername: json["profUsername"],
        profPhone: json["profPhone"],
        profPassword: json["profPassword"],
        profFaculty: json["profFaculty"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profName": profName,
        "profEmail": profEmail,
        "profUsername": profUsername,
        "profPhone": profPhone,
        "profPassword": profPassword,
        "profFaculty": profFaculty,
        "role": role,
      };
}
