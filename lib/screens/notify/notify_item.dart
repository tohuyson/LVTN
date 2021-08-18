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
      height: 130.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
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
                          print("setting");
                        }),
                    Text(
                      notify!.title!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(DateFormat('HH:mm').format(
                        DateTime.parse(notify!.createdAt!)), style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w300),),
                    // Text(
                    //   '10 phút',
                    //   style: TextStyle(
                    //       fontSize: 14.sp, fontWeight: FontWeight.w300),
                    // ),
                    IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 22.sp,
                        ),
                        onPressed: () {
                          print("Map");
                        }),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
            child: Text(
              notify!.body!,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
            ),
          )
        ],
      ),
    );
  }
}
