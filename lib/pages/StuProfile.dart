import 'package:flutter/material.dart';
import 'package:project_se_app/pages/showPostStu.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

class Stuprofile extends StatefulWidget {
  const Stuprofile({super.key});

  @override
  State<Stuprofile> createState() => _StuprofileState();
}

class _StuprofileState extends State<Stuprofile> {
  void _logout() {
    final stuProvider = Provider.of<StuProvider>(context, listen: false);
    stuProvider.onlogout();

    if (!stuProvider.isAuthentication()) {
      print('logout successful');
    }

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final stuProvider = Provider.of<StuProvider>(context);

    if (!stuProvider.isAuthentication()) {
      return Center(child: Text('กรุณาเข้าสู่ระบบ'));
    }
    final stu = stuProvider.stu;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        title: const Text(
          'P R O F I L E',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title
        actions: [
          IconButton(onPressed: _logout, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // รูปโปรไฟล์
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_prof.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            // ชื่ออาจารย์
            Text(
              stu.name, // แสดงชื่ออาจารย์
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // ข้อมูลเพิ่มเติม
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ชื่อผู้ใช้: ${stu.username}', // แสดงชื่อผู้ใช้
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'อีเมล์: ${stu.email}', // แสดงอีเมล์
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'โทรศัพท์: ${stu.phone}', // แสดงหมายเลขโทรศัพท์
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'คณะ: ${stu.faculty}', // แสดงคณะ
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'สาขา: ${stu.program}', // แสดงคณะ
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPostStu()),
                );
              },
              child: const Text('ดูโพสต์'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade100,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
