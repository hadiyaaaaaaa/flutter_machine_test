import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username == 'admin' && password == 'Pass@123') {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login Failed', 'Invalid username or password',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
