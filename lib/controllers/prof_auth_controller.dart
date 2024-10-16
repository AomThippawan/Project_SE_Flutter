import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_se_app/models/prof_auth.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/variable.dart';

class ProfAuthSurvice {
  //login
  Future<ProfModel?> login(String profUsername, String profPassword) async {
    final response = await http.post(
      Uri.parse('$apiURL/api/prof/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'profUsername': profUsername, 'profPassword': profPassword}),
    );
    print(response.statusCode);
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      return ProfModel.fromJson(jsonDecode(response.body));
    } else {
      print('Login false : ${response.body}');
      return null;
    }
  }

  //register
  Future<void> register(
    String profName,
    String profEmail,
    String profUsername,
    String profPhone,
    String profPassword,
    String profFaculty,
    String role,
  ) async {
    final response = await http.post(Uri.parse('$apiURL/api/prof/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'profName': profName,
          'profEmail': profEmail,
          'profUsername': profUsername,
          'profPhone': profPhone,
          'profPassword': profPassword,
          'profFaculty': profFaculty,
          'role': role,
        }));
    print(response.statusCode);
  }

  //refresh
  Future<void> refreshToken(ProfProvider profProvider) async {
    final refreshToken = profProvider.refreshToken;

    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    }

    final response = await http.post(
      Uri.parse('$apiURL/api/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': refreshToken,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      profProvider.requestToken(responseData['accessToken']);
    } else {
      print('Failed to refresh token : ${response.body}');
      throw Exception('Failed to refresh token : ${response.body}');
    }
  }

  //get Prof

  // Future <void> _getPorf( http.Response response, ProfProvider profProvider) async{
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return;
  //   } else if (response.statusCode == 403) {
  //     await ProfAuthSurvice().refreshToken(profProvider);
  //   } else if (response.statusCode == 401) {
  //     profProvider.onlogout();
  //     throw Exception('Unauthorized');
  //   } else {
  //     throw Exception('Error : ${response.statusCode} - ${response.body}');
  //   }
  // }
}
