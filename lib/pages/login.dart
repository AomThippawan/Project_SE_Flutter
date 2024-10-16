import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_auth_controller.dart';
import 'package:project_se_app/controllers/std_auth_controller.dart';
import 'package:project_se_app/pages/ProfHome.dart';
import 'package:project_se_app/pages/StuHome.dart';
import 'package:project_se_app/pages/selectRole.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _selectedRole = 'professor'; // ค่าเริ่มต้นเป็น professor

  void _login(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      if (_selectedRole == 'professor') {
        final profAuth = ProfAuthSurvice();
        final profModel = await profAuth.login(
          _usernameController.text,
          _passwordController.text,
        );

        if (profModel != null) {
          Provider.of<ProfProvider>(context, listen: false).onlogin(profModel);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfHomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('เข้าสู่ระบบล้มเหลวสำหรับอาจารย์')));
        }
      } else if (_selectedRole == 'student') {
        final stuAuth = StudentService();
        final stuModel = await stuAuth.loginStu(
          _usernameController.text,
          _passwordController.text,
        );

        if (stuModel != null) {
          Provider.of<StuProvider>(context, listen: false).onlogin(stuModel);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StuHome()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('เข้าสู่ระบบล้มเหลวสำหรับนิสิต')));
        }
      }
    }
  }

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
        child: Stack(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(15),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'USERNAME',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: Icon(Icons.person_2_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 10 characters long';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          items: ['professor', 'student'].map((String role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedRole = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Role',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => selectRolePage(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 35, 2, 114),
                                fontSize: 16,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _login(context),
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
                          child: Text('LOGIN'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
