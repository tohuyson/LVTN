import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  late TextEditingController? email;
  late TextEditingController? username;
  late TextEditingController? phone;
  late TextEditingController? password;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    username = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    email!.dispose();
    username!.dispose();
    phone!.dispose();
    password!.dispose();
  }

  bool isEmail(String email) {
    RegExp regExp = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  Future<void> register(BuildContext context) async {
    if (Form.of(context)!.validate()) {
      if (email!.text.isNotEmpty &&
          username!.text.isNotEmpty &&
          phone!.text.isNotEmpty &&
          password!.text.isNotEmpty) {
        try {
          EasyLoading.show(status: 'Loading...');
          print(username!.text);
          print(email!.text);
          http.Response response = await http.post(
            Uri.parse(Apis.getSignUpUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'username': username!.text,
              'email': email!.text,
              'password': password!.text,
              'phone': phone!.text,
            }),
          );
          if (response.statusCode == 201) {
            EasyLoading.dismiss();
            Get.to(SignIn());
          }
          if (response.statusCode == 409) {
            showToast("Email đã tồn tại!");
          }
          if (response.statusCode == 500) {
            showToast("Server error, please try again later!");
          }
        } on TimeoutException catch (e) {
          showError(e.toString());
        } on SocketException catch (e) {
          showError(e.toString());
        }
      } else {
        showToast("Vui lòng điền đầy đủ các trường.");
      }
    } else {
      showToast("Vui lòng điền đầy đủ các trường.");
    }
  }



  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future google_SignOut() async {
    await _auth.signOut();
    await googleSignIn.signOut().then((value) => Get.offAll(SignIn()));
  }

  Future logoutFaceBook() async {
    await FacebookAuth.instance.logOut().then((value) => Get.offAll(SignIn()));
  }
}
