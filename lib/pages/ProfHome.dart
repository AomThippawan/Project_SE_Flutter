import 'package:flutter/material.dart';
import 'package:project_se_app/pages/ProfProfile.dart';
import 'package:project_se_app/pages/PullPost.dart';
import 'package:project_se_app/pages/addPostProf.dart';
import 'package:project_se_app/pages/showPostProf.dart';
import 'package:project_se_app/pages/showPostStu.dart';

class ProfHomePage extends StatefulWidget {
  const ProfHomePage({super.key});

  @override
  State<ProfHomePage> createState() => _ProfHomePageState();
}

class _ProfHomePageState extends State<ProfHomePage> {
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
                  SizedBox(height: 110),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => addPostProf()),
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
                          builder: (context) => Post(postType: 'student'),
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
                      MaterialPageRoute(
                          builder: (context) => ProfProfilePage()),
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
