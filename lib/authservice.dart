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

  //Sign out
  signOut() {
    _removeToken();
    FirebaseAuth.instance.signOut();
    Get.offAll(AuthService().handleAuth());
  }

  //SignIn
  // Future<UserCredential> signIn(AuthCredential authCreds) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   auth.userChanges();
  //   UserCredential user =
  //       await auth.signInWithCredential(authCreds).catchError((onError) {
  //     showToast('Mã xác minh không chính xác!');
  //   });
  //   return user;
  // }

  Future<UserCredential>? signIn(AuthCredential authCreds) {
    Future<UserCredential> user = FirebaseAuth.instance
        .signInWithCredential(authCreds)
        .catchError((onError) {
      showToast('Mã xác minh không chính xác!');
      // print('mã k chính xac');
    });
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<bool> signInWithOTP(String smsCode, String verId) async {
    print(smsCode);
    print(verId);
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    print(authCreds.token);
    // FirebaseAuth auth = FirebaseAuth.instance;
    // auth.userChanges();
    // final UserCredential user =
    //     await auth.signInWithCredential(authCreds).catchError((onError) {
    //   showToast('Mã xác minh không chính xác!');
    // });
    // print(authCreds.providerId);
    // UserCredential? result = await signIn(authCreds);
    // print(result?.user);
    // if (user != null) {
    //   return true;
    // }
    // if (result?.user == null) {
    //   return true;
    // }

    UserCredential? result = await signIn(authCreds);
    print(result?.user);
    // if (user != null) {
    //   return true;
    // }
    if (result?.user != null) {
      return true;
    }

    return false;
  }
// signInWithOTP(smsCode, verId) {
//   print(smsCode);
//   AuthCredential authCreds =
//       PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
//   print(authCreds.token);
//   signIn(authCreds);
// }
}
