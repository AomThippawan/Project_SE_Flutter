import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/std_post_controller.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

class UpdatePostStu extends StatefulWidget {
  final PostModel postStu;
  UpdatePostStu({required this.postStu});

  @override
  State<UpdatePostStu> createState() => _UpdatePostStuState();
}

class _UpdatePostStuState extends State<UpdatePostStu> {
  final _formkey = GlobalKey<FormState>();
  final PostService _postStuSurvice = PostService();

  late String _stskill;
  late String _stability;
  late String _stworktime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stskill = widget.postStu.stskill;
    _stability = widget.postStu.stability;
    _stworktime = widget.postStu.stworktime;
  }

  void _UpdatePost() async {
    if (_formkey.currentState!.validate()) {
      final stuProvider = Provider.of<StuProvider>(context, listen: false);
      final updatePost = PostModel(
        stskill: _stskill,
        stability: _stability,
        stworktime: _stworktime,
        id: widget.postStu.id,
      );

      try {
        await _postStuSurvice.updatePost(updatePost, stuProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post updated successfully!')),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        print('Error updating post: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating product: $e')),
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
                      'EDIT PRODUCT',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      initialValue: _stskill,
                      decoration: InputDecoration(labelText: 'JOB TITLE'),
                      onChanged: (value) {
                        _stskill = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: _stability,
                      decoration: InputDecoration(labelText: 'JOB DESCRIPTION'),
                      onChanged: (value) {
                        _stability = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: _stworktime,
                      decoration: InputDecoration(labelText: 'JOB LOCATION'),
                      onChanged: (value) {
                        _stworktime = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
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
                          onPressed: _UpdatePost,
                          child: Text('EDIT'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade100,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
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
