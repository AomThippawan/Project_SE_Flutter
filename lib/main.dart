import 'package:flutter/material.dart';
import 'package:project_se_app/pages/login.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                StuProvider()), // เปลี่ยนชื่อเป็น StdProvider ให้ตรงกับชื่อคลาส
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'product app',
      home: loginPage(),
      routes: {
        '/login': (context) => loginPage(),
      },
    );
  }
}
