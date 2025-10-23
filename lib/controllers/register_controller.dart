import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru_app/screens/login_screen.dart';
import 'package:simaru_app/services/register_service.dart';

class RegisterController extends GetxController {
  final RegisterService _service = Get.put(RegisterService());

  // Observable variable
  var isLoading = false.obs;

  // Text editing controllers untuk input register
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Fungsi register
  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password dan konfirmasi password tidak cocok');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _service.register(
        name,
        email,
        password,
        confirmPassword,
      );

      if (response != null && response['accessToken'] != null) {
        Get.snackbar('Sukses', 'Pendaftaran berhasil');
        // Navigasi ke halaman login atau home setelah register
        // Get.offAllNamed('/login');
        Get.to(() => const LoginScreen());
      } else {
        Get.snackbar('Gagal', response?['message'] ?? 'Pendaftaran gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
