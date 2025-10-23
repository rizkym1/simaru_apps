import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:simaru_app/controllers/login_controller.dart';
import 'package:simaru_app/controllers/register_controller.dart';
import 'package:simaru_app/screens/home_screen.dart';
import 'package:simaru_app/screens/login_screen.dart';
// import 'package:simaru/screens/home_screen.dart'; // opsional nanti

void main() async {
  // Pastikan GetX dan GetStorage diinisialisasi sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simaru App',
      theme: ThemeData(
        primaryColor: const Color(0xFF003366),
        useMaterial3: true,
      ),
      // Jika token sudah ada, langsung ke home, kalau belum ke login
      home: const LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
        Get.put(RegisterController());
        Get.put(HomeScreen());
      }),
    );
  }
}
