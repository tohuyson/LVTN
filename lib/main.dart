import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/forgot_password.dart';
import 'package:fooddelivery/screens/signin.dart';
import 'package:fooddelivery/screens/signup.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Delivery',
      theme: ThemeData(
        primaryColor: Color(0xff1e90ff),
      ),
      home: HomeScreen(),
    );
  }
}
