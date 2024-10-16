import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_se_app/models/apply.dart';
import 'package:project_se_app/variable.dart';

class ApplyService {
  Future<void> addPost(ApplyModel applyModel) async {
    try {
      final response = await http.post(
        Uri.parse('$apiURL/api/apply'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(applyModel.toJson()),
      );

      if (response.statusCode == 201) {
        print('Post added successfully: ${response.body}');
      } else {
        throw Exception(
            'Failed to add post: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding post: $e');
    }
  }
}
