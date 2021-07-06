import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phương thức thanh toán'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 414.w,
            padding: EdgeInsets.only(
                bottom: 12.h, left: 12.w, right: 12.w, top: 12.h),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: kPrimaryColorBackground, width: 2))),
            child: Text(
              'Chọn 1 hình thức thanh toán',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: kPrimaryColorBackground, width: 2))),
                  padding: EdgeInsets.only(bottom: 12.h),
                  width: 414.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 34.sp,
                            ),
                          ),
                          Text(
                            'Tiền mặt',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: kPrimaryColorBackground, width: 2))),
                  padding: EdgeInsets.only(bottom: 12.h),
                  width: 414.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 34.sp,
                            ),
                          ),
                          Text(
                            'ZaloPay',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.w),
                        // child: Icon(
                        //   Icons.check,
                        //   color: Theme.of(context).primaryColor,
                        // ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: kPrimaryColorBackground, width: 2))),
                  padding: EdgeInsets.only(bottom: 12.h),
                  width: 414.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 34.sp,
                            ),
                          ),
                          Text(
                            'MoMo',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.w),
                        // child: Icon(
                        //   Icons.check,
                        //   color: Theme.of(context).primaryColor,
                        // ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
