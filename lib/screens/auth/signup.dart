import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp> {
  late TextEditingController? email;
  late TextEditingController? mssv;
  late TextEditingController? username;

  var confirmPass = null;
  late String numberPhone;

  @override
  void initState() {
    numberPhone = Get.arguments['numberPhone'];
    email = new TextEditingController();
    mssv = new TextEditingController();
    username = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email!.dispose();
    mssv!.dispose();
    username!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Hoàn tất thông tin",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        height: 834.h,
        width: 414.w,
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 366.w,
                height: 160.h,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                child: Builder(
                  builder: (BuildContext ctx) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 366.w,
                          child: Text(
                            'Bạn đã đăng ký thành công!\nĐiền thông tin để hoàn tất',
                            style: TextStyle(fontSize: 18.sp),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0) return "Vui lòng nhập tên";
                        },
                        hintText: 'Tên người dùng',
                        icon: Icons.perm_identity,
                        controller: username,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập mã số sinh viên";
                          else
                            return null;
                        },
                        controller: mssv,
                        hintText: 'MSSV',
                        icon: Icons.perm_identity,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập Email";
                          else if (val.endsWith('@st.hcmuaf.edu.vn') == false)
                            return "Sai định dạng Email sinh viên";
                          else
                            return null;
                        },
                        controller: email,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        height: 60.h,
                        width: 414.w,
                        padding: EdgeInsets.only(left: 24.w, right: 24.w),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () {
                            if (Form.of(ctx)!.validate()) {
                              loginAndRegisterPhone(numberPhone, username!.text,
                                  email!.text, mssv!.text);
                            }
                          },
                          child: Text(
                            'Tiếp tục'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginAndRegisterPhone(
      String phone, String username, String email, String mssv) async {
    User user = FirebaseAuth.instance.currentUser!;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postloginAndRegisterPhone),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
          'username': username,
          'email': email,
          'mssv': mssv,
          'uid': user.uid,
        }),
      );
      if (response.statusCode == 201) {
        var token = jsonDecode(response.body)["token"];

        await saveToken(token);

        user.updateDisplayName(username);
        user.updateEmail(email);

        Get.offAll(() => BottomNavigation(
              selectedIndex: 2,
            ));
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
