import 'package:flutter/material.dart';
import 'package:project_se_app/pages/showPostProf.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:provider/provider.dart';

class ProfProfilePage extends StatefulWidget {
  const ProfProfilePage({super.key});

  @override
  State<ProfProfilePage> createState() => _ProfProfilePageState();
}

class _ProfProfilePageState extends State<ProfProfilePage> {
  void _logout() {
    final profProvider = Provider.of<ProfProvider>(context, listen: false);
    profProvider.onlogout();

    if (!profProvider.isAuthentication()) {
      print('logout successful');
    }

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<ProfProvider>(context);

    if (!profProvider.isAuthentication()) {
      return Center(child: Text('กรุณาเข้าสู่ระบบ'));
    }
    final prof = profProvider.user;
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
              prof.profName, // แสดงชื่ออาจารย์
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
                  'อีเมล์: ${prof.profEmail}', // แสดงอีเมล์
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ชื่อผู้ใช้: ${prof.profUsername}', // แสดงชื่อผู้ใช้
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'โทรศัพท์: ${prof.profPhone}', // แสดงหมายเลขโทรศัพท์
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'คณะ: ${prof.profFaculty}', // แสดงคณะ
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
                  MaterialPageRoute(builder: (context) => HistoryPostPorf()),
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
