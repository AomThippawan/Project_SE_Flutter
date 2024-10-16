import 'dart:convert';

import 'package:project_se_app/models/std_auth.dart';
import 'package:http/http.dart' as http;
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:project_se_app/variable.dart';

class StudentService {
  Future<StudentModel?> loginStu(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiURL2/api/student/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    print(response.statusCode); // ตรวจสอบสถานะ

    if (response.statusCode == 200) {
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  }

  //register
  Future<void> register(
      String name,
      String email,
      String username,
      String password,
      String phone,
      String faculty,
      String program,
      String sex,
      int yearofstudy) async {
    final response = await http.post(
      Uri.parse('$apiURL2/api/student/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'phone': phone,
        'faculty': faculty,
        'program': program,
        'sex': sex,
        'yearofstudy': yearofstudy
      }),
    );
    print(response.statusCode);
  }

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
}
