import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Controller untuk setiap TextField
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Variabel observable untuk state show/hide password
  var isPasswordHidden = true.obs;

  // Fungsi yang akan dipanggil saat tombol login ditekan
  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Validasi sederhana
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password tidak boleh kosong');
      return;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Format email tidak valid');
      return;
    }

    // Jika validasi berhasil, cetak di konsol (ganti dengan logika API Anda)
    print("Mencoba login dengan:");
    print("Email: $email");
    print("Password: $password");

    Get.snackbar(
      'Sukses',
      'Login berhasil!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Contoh navigasi ke halaman lain setelah login
    // Get.offAllNamed('/home');
  }

  // Penting untuk membersihkan controller saat halaman ditutup
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
