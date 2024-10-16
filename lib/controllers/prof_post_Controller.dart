import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_se_app/controllers/prof_auth_controller.dart';
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/variable.dart';

class PostProfSurvice {
//------------------------------------------------------------------------------
  Future<void> _response(
      http.Response response, ProfProvider profProvider) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 403) {
      await ProfAuthSurvice().refreshToken(profProvider);
    } else if (response.statusCode == 401) {
      profProvider.onlogout();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Error : ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<PostProfModel>> fetchPostprof(ProfProvider profProvider) async {
    final response =
        await http.get(Uri.parse('$apiURL/api/postProf'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${profProvider.accessToken}',
    });

    await _response(response, profProvider);

    List<dynamic> postProfList = jsonDecode(response.body);
    return postProfList.map((json) => PostProfModel.fromJson(json)).toList();
  }

//------------------------------------------------------------------------------
  //add product
  Future<void> addProduct(
      PostProfModel postProfModel, ProfProvider profProvider) async {
    final response = await http.post(Uri.parse('$apiURL/api/postProf/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${profProvider.accessToken}',
        },
        body: jsonEncode(postProfModel.toJson()));
    await _response(response, profProvider);
  }

//------------------------------------------------------------------------------
  //update
  Future<void> updatePost(
      PostProfModel postProfModel, ProfProvider profProvider) async {
    final response = await http.put(
        Uri.parse('$apiURL/api/postProf/update/${postProfModel.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${profProvider.accessToken}',
        },
        body: jsonEncode(postProfModel.toJson()));
    await _response(response, profProvider);
  }

//------------------------------------------------------------------------------
  //delete
  Future<void> deleteProduct(
      String postProf_id, ProfProvider profProvider) async {
    final response = await http.delete(
      Uri.parse('$apiURL/api/postProf/delete/${postProf_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${profProvider.accessToken}',
      },
    );
    await _response(response, profProvider);
  }
}
