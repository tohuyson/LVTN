import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/notify.dart';
import 'package:intl/intl.dart';

class NotifyItem extends StatelessWidget {
  final Notify? notify;

  NotifyItem({this.notify});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 35.h,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 22.sp,
                        ),
                        onPressed: () {
                        }),
                    Text(
                      notify!.title!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(
                            DateTime.parse(notify!.updatedAt!).toLocal()),
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            // height: 50.h,
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 30.h),
            child: Text(
              notify!.body!,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
            ),
          )
        ],
      ),
    );
  }
}
