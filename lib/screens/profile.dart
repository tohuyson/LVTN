import 'package:flutter/material.dart';
import 'package:fooddelivery/components/avatar.dart';
import 'package:fooddelivery/components/item_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  final int selectedIndex;

  Profile(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Avatar(),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            children: [
              ItemProfile(
                title: 'Thanh toán',
                description: 'Thêm ví điện tử',
              ),
              ItemProfile(
                title: 'Địa chỉ',
                description: '',
              ),
              ItemProfile(
                title: 'Người giao hàng',
                description: '',
              ),
              ItemProfile(
                title: 'Đơn hàng của tôi',
                description: '',
              ),
              ItemProfile(
                title: 'Trung tâm hỗ trợ',
                description: '',
              ),
              ItemProfile(
                title: 'Chính sách và quy định',
                description: '',
              ),
              ItemProfile(
                title: 'Cài đặt',
                description: '',
              ),
              InkWell(
                onTap: () {
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 12.w, right: 12.w),
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
