import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/std_post_controller.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

import '../providers/stdProvider.dart';

class AddPostStu extends StatefulWidget {
  const AddPostStu({super.key});

  @override
  State<AddPostStu> createState() => _AddPostStuState();
}

class _AddPostStuState extends State<AddPostStu> {
  final _formkey = GlobalKey<FormState>();
  final _postStuSurvice = PostService();

  String _stskill = '';
  String _stability = '';
  String _stworktime = '';

  void _AddPost() async {
    if (_formkey.currentState!.validate()) {
      final stuProvider = Provider.of<StuProvider>(context, listen: false);
      final NewPost = PostModel(
          stskill: _stskill,
          stability: _stability,
          stworktime: _stworktime,
          id: '');

      try {
        await _postStuSurvice.addPost(NewPost, stuProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post added successfully!')),
        );
        // ไปยังหน้า HomePage หลังจากเพิ่มผลิตภัณฑ์สำเร็จ
        Navigator.of(context).pop(
            true); // หรือใช้ Navigator.of(context).pushReplacementNamed('/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Container(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade50,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CREATE POST',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Skill',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the skill';
                        }
                        return null;
                      },
                      onChanged: (value) => _stskill = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Ability',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the ability';
                        }
                        return null;
                      },
                      onChanged: (value) => _stability = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Skill',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the skill';
                        }
                        return null;
                      },
                      onChanged: (value) => _stskill = value,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // กลับไปยังหน้าเข้าสู่ระบบ
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade100,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          child: Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: _AddPost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade100,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
