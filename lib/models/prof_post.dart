// To parse this JSON data, do
//
//     final postProfModel = postProfModelFromJson(jsonString);

import 'dart:convert';

PostProfModel postProfModelFromJson(String str) =>
    PostProfModel.fromJson(json.decode(str));

String postProfModelToJson(PostProfModel data) => json.encode(data.toJson());

class PostProfModel {
  String jobtitle;
  String jobdescription;
  String joblocation;
  String jobbuilding;
  String jobroom;
  String jobtimeStart;
  String jobtimeEnd;
  int count;
  int reserveCount;
  String travelingType;
  String foodSup;
  String salary;
  String id;

  PostProfModel({
    required this.jobtitle,
    required this.jobdescription,
    required this.joblocation,
    required this.jobbuilding,
    required this.jobroom,
    required this.jobtimeStart,
    required this.jobtimeEnd,
    required this.count,
    required this.reserveCount,
    required this.travelingType,
    required this.foodSup,
    required this.salary,
    required this.id,
  });

  factory PostProfModel.fromJson(Map<String, dynamic> json) => PostProfModel(
        jobtitle: json["Jobtitle"],
        jobdescription: json["Jobdescription"],
        joblocation: json["Joblocation"],
        jobbuilding: json["Jobbuilding"],
        jobroom: json["Jobroom"],
        jobtimeStart: json["Jobtime_start"],
        jobtimeEnd: json["Jobtime_end"],
        count: json["Count"],
        reserveCount: json["Reserve_count"],
        travelingType: json["Traveling_type"],
        foodSup: json["Food_Sup"],
        salary: json["Salary"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "Jobtitle": jobtitle,
        "Jobdescription": jobdescription,
        "Joblocation": joblocation,
        "Jobbuilding": jobbuilding,
        "Jobroom": jobroom,
        "Jobtime_start": jobtimeStart,
        "Jobtime_end": jobtimeEnd,
        "Count": count,
        "Reserve_count": reserveCount,
        "Traveling_type": travelingType,
        "Food_Sup": foodSup,
        "Salary": salary,
        "_id": id,
      };
}
