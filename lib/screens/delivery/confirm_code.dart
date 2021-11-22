import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/auth/widgets/input_field.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ConfirmCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfirmCode();
  }
}

class _ConfirmCode extends State<ConfirmCode> {
  late TextEditingController? code;

  @override
  void initState() {
    code = new TextEditingController();
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
        elevation: 0,
        leading: BackButton(
            ),
        centerTitle: true,
        title: Text(
          "Xác thực người dùng",
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
                            'Vui lòng kiểm tra Email để lấy mã xác minh',
                            style: TextStyle(fontSize: 18.sp),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      InputField(
                        validator: (val) {
                          if (val!.length == 0)
                            return "Vui lòng nhập mã xác thực";
                        },
                        hintText: 'Mã xác thực',
                        icon: Icons.perm_identity,
                        controller: code,
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
                          onPressed: () async {
                            var code = await confirmCode(ctx);
                            if (code == 200) {
                              showToast(
                                  'Bạn đã đăng ký thành công. Nhận đơn hàng ngay!');
                              Get.offAll(BottomNavigation(selectedIndex: 4));
                            } else if (code == 204) {
                              showToast('Mã xác minh sai!');
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

  Future<int?> confirmCode(BuildContext context) async {
    if (Form.of(context)!.validate()) {
      String? token = await getToken();
      try {
        http.Response response = await http.post(
          Uri.parse(Apis.confirmCodeUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'code': code!.text,
          }),
        );

        return response.statusCode;
      } on TimeoutException catch (e) {
        showError(e.toString());
      } on SocketException catch (e) {
        showError(e.toString());
      }
    }
  }
}
