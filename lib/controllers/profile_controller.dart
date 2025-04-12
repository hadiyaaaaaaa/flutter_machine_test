import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;
  var imageFile = Rx<File?>(null);

  final nameController = TextEditingController();
  final passController = TextEditingController();

  void updateProfile() {
    if (nameController.text.isNotEmpty) {
      username.value = nameController.text;
    }
    if (passController.text.isNotEmpty) {
      password.value = passController.text;
    }

    Get.snackbar('Success', 'Profile updated');
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
}
