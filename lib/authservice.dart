import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: checkLogin(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return BottomNavigation(selectedIndex: 2);
                  } else {
                    return SignIn();
                  }
                });
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

  signOut() {
    _removeToken();
    FirebaseAuth.instance.signOut();
    Get.offAll(AuthService().handleAuth());
  }

  Future<UserCredential>? signIn(AuthCredential authCreds) {
    Future<UserCredential> user = FirebaseAuth.instance
        .signInWithCredential(authCreds)
        .catchError((onError) {
      showToast('Mã xác minh không chính xác!');
    });
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<bool> signInWithOTP(String smsCode, String verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);

    UserCredential? result = await signIn(authCreds);
    print(result?.user);
    if (result?.user != null) {
      return true;
    }

    return false;
  }
}
