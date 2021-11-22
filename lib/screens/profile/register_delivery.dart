import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/delivery/confirm_code.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterDelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterDelivery();
  }
}

class _RegisterDelivery extends State<RegisterDelivery> {
  late int user_id;

  @override
  void initState() {
    user_id = Get.arguments['user_id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Đăng ký'),
        centerTitle: true,
      ),
      body: Container(
        height: 834.h,
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              width: 414.w,
              height: 300.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Text(
                      'Bạn có muốn trở thành người giao hàng của chúng tôi không?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20.sp),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text('Đăng ký làm người giao hàng'),
                          content:
                              const Text('Bạn có chắc chắn muốn đăng ký?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () async {
                                EasyLoading.show();
                                var code = await sendMailCode();
                                Get.back();
                                if (code == 200) {
                                  EasyLoading.dismiss();
                                  Get.to(ConfirmCode());
                                } else if (code == 401) {
                                  showToast('Đăng ký không thành công!');
                                }
                              },
                              child: const Text(
                                'Đăng ký',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ]);
                    });
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 30.h, bottom: 10.h, left: 12.w, right: 12.w),
                height: 45.h,
                width: 120.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'Đăng Ký'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int?> sendMailCode() async {
    String? token = await getToken();
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.registerDeliveryUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
      );

      return response.statusCode;
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }

  Future<void> updateDelivery() async {
    String? token = await getToken();
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.updateDeliveryUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'id': user_id,
        }),
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        Users? users = UsersJson.fromJson(parsedJson).users;
        Get.back(result: users);
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
