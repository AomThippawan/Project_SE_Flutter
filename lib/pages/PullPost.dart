import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_se_app/controllers/pullPost.dart';
import 'package:project_se_app/models/apply.dart';
import 'package:project_se_app/models/prof_auth.dart';
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/models/std_auth.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/pages/apply.dart';
import 'package:project_se_app/variable.dart'; // Import variable for apiURL

class Post extends StatefulWidget {
  final String postType; // รับคีย์เวิร์ดจากหน้าอื่น

  const Post({super.key, required this.postType}); // required postType

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List<PostModel> poststu = [];
  final _postStu = PullPostStu();

  List<PostProfModel> postprof = [];
  final _postProf = PullPostProf();

  // Map to hold student and professor data
  Map<String, Stu> studentMap = {};
  Map<String, Prof> professorMap = {};

  @override
  void initState() {
    super.initState();
    if (widget.postType == 'student') {
      fetchPoststu(); // เรียกข้อมูลโพสต์ของนักเรียน
    } else if (widget.postType == 'professor') {
      fetchPostprof(); // เรียกข้อมูลโพสต์ของอาจารย์
    }
  }

  Future<void> fetchPoststu() async {
    try {
      final postStuList = await _postStu.fetchPostStudent();
      setState(() {
        poststu = postStuList;
      });

      // Fetch student details and populate the map
      for (var post in poststu) {
        final student =
            await fetchStudentById(post.id); // เรียกใช้ fetchStudentById
        studentMap[post.id] = student;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching student posts: $e')),
      );
    }
  }

  Future<void> fetchPostprof() async {
    try {
      final postProfList = await _postProf.fetchPostProffessor();
      setState(() {
        postprof = postProfList;
      });

      // Fetch professor details and populate the map
      for (var post in postprof) {
        final professor =
            await fetchProfessorById(post.id); // เรียกใช้ fetchProfessorById
        professorMap[post.id] = professor;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching professor posts: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.postType == 'student' ? 'Student Posts' : 'Professor Posts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue.shade800,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button and icon colors to white
        ),
      ),
      backgroundColor: Colors.lightBlue.shade800,
      body: widget.postType == 'student'
          ? buildStudentPostList()
          : buildProfessorPostList(),
    );
  }

  // Widget สำหรับแสดงโพสต์ของนักเรียน
  Widget buildStudentPostList() {
    if (poststu.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: poststu.length,
      itemBuilder: (context, index) {
        final post = poststu[index];
        final student = studentMap[post.id]; // Get the student from the map
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Student: ${student?.name ?? 'Unknown'}"), // แสดงชื่อของนิสิต
                SizedBox(height: 5),
                Text(post.stskill),
                SizedBox(height: 5),
                Text(post.stability),
                SizedBox(height: 5),
                Text(post.stworktime),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget สำหรับแสดงโพสต์ของอาจารย์
  Widget buildProfessorPostList() {
    if (postprof.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: postprof.length,
      itemBuilder: (context, index) {
        final post = postprof[index];
        final professor =
            professorMap[post.id]; // Get the professor from the map
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Professor: ${professor?.profName ?? 'Unknown'}"), // แสดงชื่อของอาจารย์
                SizedBox(height: 5),
                Text(post.jobtitle),
                SizedBox(height: 5),
                Text(post.jobdescription),
                SizedBox(height: 5),
                Text(post.joblocation),
                SizedBox(height: 5),
                Text(post.jobbuilding),
                SizedBox(height: 5),
                Text(post.jobroom),
                SizedBox(height: 5),
                Text(post.travelingType),
                SizedBox(height: 5),
                Text(post.foodSup),
                SizedBox(height: 5),
                Text(post.jobtimeStart),
                SizedBox(height: 5),
                Text(post.jobtimeEnd),
                SizedBox(height: 5),
                Text(post.count.toString()),
                SizedBox(height: 5),
                Text(post.reserveCount.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Apply()),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color:
                              Colors.lightBlue.shade900, // เปลี่ยนสีตามต้องการ
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'ApplyJob',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // ฟังก์ชันสำหรับดึงข้อมูลนิสิตตาม ID
  Future<Stu> fetchStudentById(String id) async {
    final response =
        await http.get(Uri.parse('$apiURL2/api/student/show/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return Stu.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error fetching student: ${response.statusCode}');
    }
  }

  // ฟังก์ชันสำหรับดึงข้อมูลอาจารย์ตาม ID
  Future<Prof> fetchProfessorById(String id) async {
    final response =
        await http.get(Uri.parse('$apiURL/api/prof/show/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return Prof.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error fetching professor: ${response.statusCode}');
    }
  }
}
