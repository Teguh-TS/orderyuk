import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makanyuk/app/modules/home/views/home_view.dart';
import 'package:makanyuk/app/modules/home/views/login_view.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isPasswordVisible = false.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Fungsi Login
  Future<void> login() async {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Firebase Authentication untuk login
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Jika login berhasil, navigasi ke HomeView
      Get.offAll(() => HomeView());
    } catch (e) {
      // Menampilkan error jika login gagal
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi Register
  Future<void> register() async {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Firebase Authentication untuk registrasi
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // Menampilkan notifikasi sukses
        Get.snackbar(
          "Success",
          "Account created successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        // Navigasi kembali ke LoginView
        Get.off(() => LoginView());
      } catch (e) {
        // Menampilkan error jika registrasi gagal
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
