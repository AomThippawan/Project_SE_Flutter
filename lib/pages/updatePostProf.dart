import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_post_Controller.dart';
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:provider/provider.dart';

class UpdatePostProf extends StatefulWidget {
  final PostProfModel postProf;

  UpdatePostProf({required this.postProf});

  @override
  State<UpdatePostProf> createState() => _UpdatePostProfState();
}

class _UpdatePostProfState extends State<UpdatePostProf> {
  final _formkey = GlobalKey<FormState>();
  final PostProfSurvice _postProfSurvice = PostProfSurvice();

  late String _jobtitle = '';
  late String _jobdescription = '';
  late String _joblocation = '';
  late String _jobbuilding = '';
  late String _jobroom = '';
  late String _jobtimeStart = '';
  late String _jobtimeEnd = '';
  late int _count = 0;
  late int _reserveCount = 0;
  late String _travelingType = '';
  late String _foodSup = '';
  late String _salary = '';
  late String _id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobtitle = widget.postProf.jobtitle;
    _jobdescription = widget.postProf.jobdescription;
    _joblocation = widget.postProf.joblocation;
    _jobbuilding = widget.postProf.jobbuilding;
    _jobroom = widget.postProf.jobroom;
    _jobtimeStart = widget.postProf.jobtimeStart;
    _jobtimeEnd = widget.postProf.jobtimeEnd;
    _count = widget.postProf.count;
    _reserveCount = widget.postProf.reserveCount;
    _travelingType = widget.postProf.travelingType;
    _foodSup = widget.postProf.foodSup;
    _salary = widget.postProf.salary;
    _id = widget.postProf.id;
  }

  void _UpdatePost() async {
    if (_formkey.currentState!.validate()) {
      final profProvider = Provider.of<ProfProvider>(context, listen: false);
      final updatePost = PostProfModel(
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
        id: _id,
      );

      try {
        await _postProfSurvice.updatePost(updatePost, profProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product updated successfully!')),
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
                      SizedBox(height: 15),
                      Text(
                        'EDIT PRODUCT',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        initialValue: _jobtitle,
                        decoration: InputDecoration(labelText: 'JOB TITLE'),
                        onChanged: (value) {
                          _jobtitle = value;
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
                        initialValue: _jobdescription,
                        decoration:
                            InputDecoration(labelText: 'JOB DESCRIPTION'),
                        onChanged: (value) {
                          _jobdescription = value;
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
                        initialValue: _joblocation,
                        decoration: InputDecoration(labelText: 'JOB LOCATION'),
                        onChanged: (value) {
                          _joblocation = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _jobbuilding,
                        decoration: InputDecoration(labelText: 'JOB BUILDING'),
                        onChanged: (value) {
                          _jobbuilding = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job building';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _jobroom,
                        decoration: InputDecoration(labelText: 'JOB ROOM'),
                        onChanged: (value) {
                          _jobroom = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job room';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _jobtimeStart,
                        decoration:
                            InputDecoration(labelText: 'JOB TIME START'),
                        onChanged: (value) {
                          _jobtimeStart = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job start time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _jobtimeEnd,
                        decoration: InputDecoration(labelText: 'JOB TIME END'),
                        onChanged: (value) {
                          _jobtimeEnd = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job end time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _count.toString(),
                        decoration: InputDecoration(labelText: 'COUNT'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _count = int.tryParse(value) ?? 0;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a count';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _reserveCount.toString(),
                        decoration: InputDecoration(labelText: 'RESERVE COUNT'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _reserveCount = int.tryParse(value) ?? 0;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a reserve count';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _travelingType,
                        decoration:
                            InputDecoration(labelText: 'TRAVELING TYPE'),
                        onChanged: (value) {
                          _travelingType = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a traveling type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _foodSup,
                        decoration: InputDecoration(labelText: 'FOOD SUPPLY'),
                        onChanged: (value) {
                          _foodSup = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter food supply information';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _salary,
                        decoration: InputDecoration(labelText: 'SALARY'),
                        onChanged: (value) {
                          _salary = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a salary';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // กลับไปยังหน้าเข้าสู่ระบบ
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
      ),
    );
  }
}
