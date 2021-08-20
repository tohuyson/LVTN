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
    return FutureBuilder(
        future: checkLogin(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigation(selectedIndex: 2);
          } else {
            return SignIn();
          }
        });
  }

  Future<bool> checkLogin() async {
    var token = await getToken();
    return token!.isNotEmpty;
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

  Future<bool> signInWithOTP(smsCode, verId, phoneNumber) async {
    print(smsCode);
    print(verId);
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    final UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(authCreds);
    // print(authCreds.providerId);
    // UserCredential result = await signIn(authCreds);
    // print(result.user);
    if (user != null) {
      return true;
    }
    // if (result.user != null) {
    //   return true;
    // }
    return false;
  }
}
