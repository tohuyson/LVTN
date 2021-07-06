import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/screens/auth/signup.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  // late final GlobalKey<FormState> formKeySignUp;

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
    // TODO: implement onReady
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
    // formKeySignUp.currentState!.validate();
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

  Future<void> _removeToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
  }

  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = 'Bearer ' + (await _prefs.getString('token'))!;
    print(token);
    try {
      print(Apis.getLogoutUrl);
      http.Response response = await http.post(
        Uri.parse(Apis.getLogoutUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': token,
        },
      ).timeout(Duration(seconds: 10));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _removeToken();
        Get.offAll(SignIn());
      }
      if (response.statusCode == 401) {
        showToast("Logout failed.");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
  }

  AccessToken? _accessToken;

  // Future<void> loginWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login(
  //       loginBehavior: LoginBehavior
  //           .dialogOnly); // by the fault we request the email and the public profile
  //
  //   // loginBehavior is only supported for Android devices, for ios it will be ignored
  //   // final result = await FacebookAuth.instance.login(
  //   //   permissions: [
  //   //     'email',
  //   //     'public_profile',
  //   //     'user_birthday',
  //   //     'user_friends',
  //   //     'user_gender',
  //   //     'user_link'
  //   //   ],
  //   //   loginBehavior: LoginBehavior
  //   //       .dialogOnly, // (only android) show an authentication dialog instead of redirecting to facebook app
  //   // );
  //
  //   if (result.status == LoginStatus.success) {
  //     _accessToken = result.accessToken;
  //     _printCredentials();
  //     // get the user data
  //     // by default we get the userId, email,name and picture
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _userData = userData;
  //     Get.offAll(BottomNavigation());
  //   } else {
  //     print('thaat bai');
  //     print(result.status);
  //     print(result.message);
  //   }
  //
  // }

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
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
