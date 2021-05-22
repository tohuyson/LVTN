import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/function_profile.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/profile/item_profile.dart';

import 'avatar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FunctionProfile> list_function= [
      FunctionProfile(name: 'Thanh toán'),
      FunctionProfile(name: 'Địa chỉ'),
      FunctionProfile(name:  'Người giao hàng'),
      FunctionProfile(name: 'Đơn hàng của tôi'),
      FunctionProfile(name:  'Trung tâm hỗ trợ'),
      FunctionProfile(name: 'Chính sách và quy định'),
      FunctionProfile(name: 'Cài đặt'),
    ];
    Users users = new Users(name: 'Huy Sơn', list_function: list_function );
    return Scaffold(
      body: Column(
        children: [
          Avatar(username: users.name ,),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            children: [
              for( FunctionProfile f in users.list_function) ItemProfile(name_function: f.name,),
              InkWell(
                onTap: () {
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 12.w, right: 12.w),
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
