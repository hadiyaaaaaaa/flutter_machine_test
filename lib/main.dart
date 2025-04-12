import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/pages/product_detail_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/home', page: () => HomePage()),
      GetPage(name: '/profile', page: () => ProfilePage()),
      GetPage(name: '/detail', page: () => ProductDetailPage()),
    ],
  ));
}
