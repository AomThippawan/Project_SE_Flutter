import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/std_post_controller.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/pages/PullPost.dart';
import 'package:project_se_app/pages/StuProfile.dart';
import 'package:project_se_app/pages/addPostStu.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

class StuHome extends StatefulWidget {
  const StuHome({super.key});

  @override
  State<StuHome> createState() => _StuHomeState();
}

class _StuHomeState extends State<StuHome> {
  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white
                  .withOpacity(0.6), // ปรับค่าความโปร่งใสที่นี่ (0.0-1.0)
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPostStu()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Row(
                        // ใช้ Row เพื่อจัดตำแหน่ง
                        children: [
                          Padding(
                            // เพิ่ม Padding รอบๆ ข้อความ
                            padding: const EdgeInsets.only(
                                left: 8.0), // ระยะห่างทางด้านซ้าย
                            child: Text(
                              'โพสต์....', // ข้อความในกล่อง
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // เรียกใช้ HistoryPostStu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Post(postType: 'professor'),
                        ),
                      );
                    },
                    child: Text('แสดงโพสต์'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade100,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Stuprofile()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/profile_prof.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
