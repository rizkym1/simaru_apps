import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaru_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color unigalColor = Color(0xFF003366);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: unigalColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => const LoginScreen());
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Selamat datang di Dashboard!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: unigalColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
