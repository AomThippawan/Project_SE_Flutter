import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_auth_controller.dart';
import 'package:project_se_app/pages/login.dart';

class ProfRegisterPage extends StatefulWidget {
  const ProfRegisterPage({super.key});

  @override
  State<ProfRegisterPage> createState() => _ProfRegisterPageState();
}

class _ProfRegisterPageState extends State<ProfRegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ProfusernameController = TextEditingController();
  final TextEditingController _ProfpasswordController = TextEditingController();
  final TextEditingController _profNameController = TextEditingController();
  final TextEditingController _profEmailController = TextEditingController();
  final TextEditingController _profPhoneController = TextEditingController();
  final TextEditingController _profFacultyController = TextEditingController();
  String _role = 'Professor';

  final profAuthSurvice = ProfAuthSurvice();

  Future<void> _register() async {
    if (_ProfusernameController.text.isEmpty ||
        _ProfpasswordController.text.isEmpty ||
        _profNameController.text.isEmpty ||
        _profEmailController.text.isEmpty ||
        _profPhoneController.text.isEmpty ||
        _profFacultyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    if (_formkey.currentState!.validate()) {
      print('username:${_ProfusernameController.text}');
      print('password:${_ProfpasswordController.text}');
      print('name:${_profNameController.text}');
      print('email:${_profEmailController.text}');
      print('phone:${_profPhoneController.text}');
      print('phone:${_profFacultyController.text}');
      print('role:${_role}');
    }

    try {
      final user = ProfAuthSurvice().register(
          _ProfusernameController.text,
          _ProfpasswordController.text,
          _profNameController.text,
          _profEmailController.text,
          _profPhoneController.text,
          _profFacultyController.text,
          _role);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => loginPage()),
        );
      } else {
        // ถ้าการลงทะเบียนล้มเหลว
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
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
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text('SIGN UP',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                      Text('PROFESSOR', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _profNameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _profEmailController,
                        decoration: InputDecoration(
                          labelText: 'Email@tsu.ac.th',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _ProfusernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _profPhoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _ProfpasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller:
                            _profFacultyController, // ใช้ TextEditingController สำหรับ Faculty
                        decoration: InputDecoration(
                          labelText: 'Faculty',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your faculty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Distribute space between buttons
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            child: Text('Back'),
                          ),
                          ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.shade100,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Register'),
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
