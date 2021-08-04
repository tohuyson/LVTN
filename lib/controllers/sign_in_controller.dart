import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/signin.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  // late TextEditingController? email;
  late TextEditingController? password;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User> _firebaseUser = Rxn<User>();

  bool isUserSignedIn = false;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    // email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    // email!.dispose();
    password!.dispose();
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }

  // Future<void> login(BuildContext context) async {
  //   Form.of(context)!.validate();
  //   print(email!.text);
  //   print(password!.text);
  //   EasyLoading.show(status: 'Loading...');
  //   if (email!.text.isNotEmpty && password!.text.isNotEmpty) {
  //     try {
  //       print(Apis.getSignInUrl);
  //       http.Response response = await http.post(
  //         Uri.parse(Apis.getSignInUrl),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, String>{
  //           'email': email!.text,
  //           'password': password!.text,
  //         }),
  //       );
  //       print(response.statusCode);
  //       if (response.statusCode == 200) {
  //         var token = jsonDecode(response.body)["token"];
  //         print('token $token');
  //         if (token != null) {
  //           print("TOKEN: " + token);
  //           await EasyLoading.dismiss();
  //           await _saveToken(token);
  //           Get.to(() => BottomNavigation(selectedIndex: 2,));
  //         }
  //       }
  //       if (response.statusCode == 401) {
  //         showToast("Đăng nhập thất bại!");
  //       }
  //       if (response.statusCode == 500) {
  //         showToast("Hệ thống bị lỗi, Vui lòng thử lại sau!");
  //       }
  //     } on TimeoutException catch (e) {
  //       showError(e.toString());
  //     } on SocketException catch (e) {
  //       showError(e.toString());
  //       print(e.toString());
  //     }
  //   } else {
  //     showToast("Vui lòng điền email và mật khẩu.");
  //   }
  // }

  Future<User?> signInWithFacebook() async {
    User user;
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      'email',
      'public_profile',
    ], loginBehavior: LoginBehavior.webViewOnly);

    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = userCredential.user!;
      // print(user);
      var graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${result.accessToken!.token}'));

      var profile = json.decode(graphResponse.body);
      String name = profile['name'];
      String email = profile['email'];
      String phone = '0';
      String avatar = profile['picture']['data']['url'];

      print(profile.toString());
      print(profile['picture']['data']['url']);

      postRegisger(name, email, phone, avatar);
      return user;
    } else if (result.status == LoginStatus.failed) {
      Get.to(SignIn());
    }
    return null;
  }

  Future<User?> google_SignIn() async {
    User user;
    bool isSignedIn = await googleSignIn.isSignedIn();

    print(isSignedIn.toString());

    if (isSignedIn) {
      user = _auth.currentUser!;
      print(user.email);
      print(user.toString());
      Get.off(BottomNavigation(selectedIndex: 2,));
    } else {
      final GoogleSignInAccount googleUser = (await googleSignIn.signIn())!;
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential result = await _auth.signInWithCredential(credential);
        user = result.user!;
        isUserSignedIn = await googleSignIn.isSignedIn();

        print(user.displayName!);
        print(user.email!);
        if (user != null) {
          String? phone = user.phoneNumber;
          if (phone == null) {
            phone = '0';
          }
          print(phone);
          postRegisger(user.displayName!, user.email!, phone, user.photoURL!);

          return user;
        } else {
          Get.to(SignIn());
        }
      } else {
        showToast('Đăng nhập thất bại!');
      }
    }
    return null;
  }

  Future<void> postRegisger(
      String username, String email, String phone, String avatar) async {
    try {
      EasyLoading.show(status: 'Loading...');
      http.Response response = await http.post(
        Uri.parse(Apis.getSignInSocialUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'phone': phone,
          'avatar': avatar,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.off(BottomNavigation(selectedIndex: 2,));
      }
      if (response.statusCode == 204) {
        EasyLoading.dismiss();
        Get.off(BottomNavigation(selectedIndex: 2,));
      }
      if (response.statusCode == 500) {
        showToast("Server error, please try again later!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
