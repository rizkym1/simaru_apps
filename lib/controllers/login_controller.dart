import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru_app/services/login_service.dart';
import 'package:simaru_app/screens/home_screen.dart';

class LoginController extends GetxController {
  final LoginService _service = Get.put(LoginService());
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password harus diisi');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _service.login(email, password);

      if (response != null && response['accessToken'] != null) {
        Get.snackbar('Sukses', 'Login berhasil');
        // Navigasi ke dashboard setelah login sukses
        Get.to(() => const HomeScreen());
      } else {
        Get.snackbar('Gagal', 'Email atau password salah');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
