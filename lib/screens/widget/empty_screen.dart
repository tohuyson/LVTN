import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  final String text;

  EmptyScreen({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 630.h,
            width: 414.w,
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
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 20.sp),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
