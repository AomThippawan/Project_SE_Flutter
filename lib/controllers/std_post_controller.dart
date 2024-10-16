import 'dart:convert';

import 'package:project_se_app/controllers/std_auth_controller.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:http/http.dart' as http;
import 'package:project_se_app/variable.dart';

class PostService {
  Future<void> refreshToken(StuProvider userProvider) async {
    final refreshToken = userProvider.refreshToken;

    print("Refresh Token: $refreshToken");
    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    }

    final response = await http.post(
      Uri.parse('$apiURL2/api/student/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': refreshToken,
      }),
    );

    print("Refresh Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      userProvider.requestToken(responseData['accessToken']);
    } else {
      print('Failed to refresh token : ${response.body}');
      throw Exception('Failed to refresh token : ${response.body}');
    }
  }

//------------------------------------------------------------------------------
  Future<void> _response(
      http.Response response, StuProvider stuProvider) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 403) {
      await StudentService().refreshToken(stuProvider);
    } else if (response.statusCode == 401) {
      stuProvider.onlogout();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Error : ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<PostModel>> fetchPostStu(StuProvider stuProvider) async {
    final response =
        await http.get(Uri.parse('$apiURL2/api/poststudent'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${stuProvider.accessToken}',
    });

    await _response(response, stuProvider);

    List<dynamic> postStuList = jsonDecode(response.body);
    return postStuList.map((json) => PostModel.fromJson(json)).toList();
  }

//------------------------------------------------------------------------------
  Future<void> addPost(PostModel postModel, StuProvider stuProvider) async {
    final response = await http.post(Uri.parse('$apiURL2/api/poststudent/post'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${stuProvider.accessToken}',
        },
        body: jsonEncode(postModel.toJson()));
    await _response(response, stuProvider);
  }

//------------------------------------------------------------------------------
  Future<void> updatePost(PostModel postModel, StuProvider userProvider) async {
    final response = await http.put(
        Uri.parse('$apiURL2/api/poststudent/update/${postModel.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(postModel.toJson()));
    await _response(response, userProvider);
  }

//------------------------------------------------------------------------------
  Future<void> deletePost(String postModel_id, StuProvider userProvider) async {
    final response = await http.delete(
      Uri.parse('$apiURL2/api/poststudent/delete/${postModel_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userProvider.accessToken}',
      },
    );
    await _response(response, userProvider);
  }
}
