import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:project_se_app/variable.dart';

class PullPostStu {
//Student
//------------------------------------------------------------------------------
  Future<List<PostModel>> fetchPostStudent() async {
    final response =
        await http.get(Uri.parse('$apiURL2/api/poststudent/get'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> postStuList = jsonDecode(response.body);
      return postStuList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Error : ${response.statusCode} - ${response.body}');
    }
  }
}

class PullPostProf {
//Professor
//------------------------------------------------------------------------------
  Future<List<PostProfModel>> fetchPostProffessor() async {
    final response =
        await http.get(Uri.parse('$apiURL/api/postProf'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> postProfList = jsonDecode(response.body);
      return postProfList.map((json) => PostProfModel.fromJson(json)).toList();
    } else {
      throw Exception('Error : ${response.statusCode} - ${response.body}');
    }
  }
}
