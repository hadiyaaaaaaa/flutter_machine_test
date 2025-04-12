import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  final profileCtrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: [
            GestureDetector(
              onTap: () => showImagePickerOptions(context),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileCtrl.imageFile.value != null
                    ? FileImage(profileCtrl.imageFile.value!)
                    : AssetImage('assets/logiology.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: profileCtrl.nameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            TextField(
              controller: profileCtrl.passController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: profileCtrl.updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        )),
      ),
    );
  }

  void showImagePickerOptions(BuildContext context) {
    final ctrl = Get.find<ProfileController>();

    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Take a picture'),
            onTap: () {
              ctrl.pickImage(ImageSource.camera);
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from gallery'),
            onTap: () {
              ctrl.pickImage(ImageSource.gallery);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
