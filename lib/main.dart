import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Sesuaikan path ke screen Anda
import 'package:simaru_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Langsung arahkan ke LoginScreen
      home: const LoginScreen(),
    );
  }
}
