import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_post_Controller.dart';
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:provider/provider.dart';

class addPostProf extends StatefulWidget {
  const addPostProf({super.key});

  @override
  State<addPostProf> createState() => _addPostProfState();
}

class _addPostProfState extends State<addPostProf> {
  final _formkey = GlobalKey<FormState>();
  final _postProfSurvice = PostProfSurvice();

  String _jobtitle = '';
  String _jobdescription = '';
  String _joblocation = '';
  String _jobbuilding = '';
  String _jobroom = '';
  String _jobtimeStart = '';
  String _jobtimeEnd = '';
  int _count = 0;
  int _reserveCount = 0;
  String _travelingType = '';
  String _foodSup = '';
  String _salary = '';
  String _id = '';

  void _AddPost() async {
    if (_formkey.currentState!.validate()) {
      final profProvider = Provider.of<ProfProvider>(context, listen: false);
      final NewProduct = PostProfModel(
          jobtitle: _jobtitle,
          jobdescription: _jobdescription,
          joblocation: _joblocation,
          jobbuilding: _jobbuilding,
          jobroom: _jobroom,
          jobtimeStart: _jobtimeStart,
          jobtimeEnd: _jobtimeEnd,
          count: _count,
          reserveCount: _reserveCount,
          travelingType: _travelingType,
          foodSup: _foodSup,
          salary: _salary,
          id: '');

      try {
        await _postProfSurvice.addProduct(NewProduct, profProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully!')),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: SingleChildScrollView(
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
                        labelText: 'Job Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the job title';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobtitle = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Job Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the job description';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobdescription = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                      onChanged: (value) => _joblocation = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Building',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the building';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobbuilding = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Room',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the room';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobroom = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Traveling Type',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the traveling type';
                        }
                        return null;
                      },
                      onChanged: (value) => _travelingType = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Food Support',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the traveling type';
                        }
                        return null;
                      },
                      onChanged: (value) => _foodSup = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the start time';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobtimeStart = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the end time';
                        }
                        return null;
                      },
                      onChanged: (value) => _jobtimeEnd = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Count',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the count';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Count must be a number';
                        }
                        return null;
                      },
                      onChanged: (value) => _count = int.tryParse(value) ?? 0,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Reserve Count',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the reserve count';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Reserve count must be a number';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          _reserveCount = int.tryParse(value) ?? 0,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Salary',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the salary';
                        }
                        return null;
                      },
                      onChanged: (value) => _salary = value,
                    ),
                    const SizedBox(height: 20),
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
                          child: const Text('Add Post'),
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
