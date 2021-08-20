import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/auth/signup.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyPhone();
  }
}

class _VerifyPhone extends State<VerifyPhone> {
  late TextEditingController? code;

  late String numberPhone, verificationId;
  bool isLoading = false;

  @override
  void initState() {
    code = TextEditingController();
    numberPhone = Get.arguments['numberPhone'];
    verificationId = Get.arguments['verificationId'];
    super.initState();
  }

  @override
  void dispose() {
    code!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập Mã Xác Minh'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 414.w,
          height: 834.h,
          padding: EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mã xác minh của bạn đã được gửi tới số',
                    style: TextStyle(fontSize: 18.sp),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    numberPhone,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Mã xác minh',
                    ),
                    controller: code,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.length == 0) {
                        return 'Vui lòng nhập Mã xác minh';
                      } else if (!val.isNum) {
                        return 'Sai định dạng Mã xác minh';
                      } else
                        return null;
                    },
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      onPressed: () async {
                        if (isLoading == false) {
                          print(code!.text);
                          var isSignSMS = await AuthService()
                              .signInWithOTP(code!.text.trim(), verificationId, numberPhone);
                          print(isSignSMS);

                          if (isSignSMS == true) {
                            print("vào ddaa7f true đi bạn $isSignSMS");
                            //check user đã có tồn tại hay chưa
                            bool isCheckUser = await checkUser();
                            if (isCheckUser) {
                              await loginUser();
                            } else {
                              Get.to(SignUp(),
                                  arguments: {'numberPhone': numberPhone});
                            }
                          }
                          // await AuthService().loginAndRegisterPhone(numberPhone);
                        }
                      },
                      child: Text(
                        'Tiếp tục'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    width: 100.w,
                    height: 100.h,
                    child: isLoading ? Loading() : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.checkUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': numberPhone,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['users'] != null) {
          return true;
        }
        return false;
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return false;
  }

  Future<bool> loginUser() async {
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postLoginPhoneUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': numberPhone,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        print(jsonDecode(response.body)['token']);
        await saveToken(jsonDecode(response.body)['token']);
        Get.offAll(BottomNavigation(selectedIndex: 2));
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return false;
  }
}
