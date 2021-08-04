import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigation(selectedIndex: 2);
          } else {
            return SignIn();
          }
        });
  }

  Future<void> _removeToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
  }

  //Sign out
  signOut() {
    _removeToken();
    FirebaseAuth.instance.signOut();
    Get.offAll(AuthService().handleAuth());
  }

  //SignIn
  Future<UserCredential> signIn(AuthCredential authCreds) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithCredential(authCreds)
        .catchError((onError) {
      showToast('Mã xác minh không chính xác!');
    });
    return user;
  }

  Future<bool> signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    UserCredential result = await signIn(authCreds);
    print(result.user);
    if (result.user != null) {
      return true;
    }
    return false;
  }

  Future<void> loginAndRegisterPhone(String phone) async {
    print(phone);
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postloginAndRegisterPhone),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        var token = jsonDecode(response.body)["token"];
        if (token != null) {
          print("TOKEN: " + token);
          await _saveToken(token);
          Get.offAll(() => BottomNavigation(
                selectedIndex: 2,
              ));
        }
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }
}
