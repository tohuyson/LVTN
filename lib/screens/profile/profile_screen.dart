import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/function_profile.dart';
import 'package:fooddelivery/screens/profile/avatar.dart';
import 'package:fooddelivery/screens/profile/item_profile.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Tôi'),
      ),
      body: Column(
        children: [
          Avatar(
            username: users.username,
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            children: [
              for (FunctionProfile f in users.listFunction!)
                ItemProfile(
                  functionProfile: f,
                ),
              InkWell(
                onTap: () {
                  // controller.google_Siok();
                  // controller.logoutFaceBook();
                  controller.google_SignOut();
                  // controller.logout();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 20.h, bottom: 10.h, left: 12.w, right: 12.w),
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'Đăng xuất'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
