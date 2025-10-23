import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaru_app/controllers/register_controller.dart';
import 'package:simaru_app/screens/login_screen.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});
  final Color unigalColor = const Color(0xFF003366);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: unigalColor,
                    ),
                  ),
                  const SizedBox(height: 40),

                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Konfirmasi Password",
                      prefixIcon: const Icon(Icons.lock_person_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: unigalColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () => controller.register(),
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                              : const Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Get.off(
                        () => const LoginScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    child: Text(
                      "Sudah punya akun? Login di sini",
                      style: TextStyle(
                        color: unigalColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
