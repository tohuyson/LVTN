import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/users.dart';

class Avatar extends StatelessWidget {
  final String username;

  Avatar({this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180.h,
      padding: EdgeInsets.only(top: 25.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.person,
              size: 100.sp,
            ),
            Text(
              username,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
