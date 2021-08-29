import 'package:flutter/material.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  InformationRestaurant({required this.restaurant});

  @override
  State<StatefulWidget> createState() {
    return _InformationRestaurant(restaurant: restaurant);
  }
}

class _InformationRestaurant extends State<InformationRestaurant> {
  final Restaurant restaurant;

  _InformationRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.w),
      width: 414.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            width: 390.w,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 360.w,
                  child: Text(
                    restaurant.address!,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 390,
            padding: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black12))),
            child: Row(
              children: [
                Icon(
                  Icons.access_alarm,
                  size: 20,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text('Giờ mở cửa : 10:00 sáng'),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(width: 390.w, child: Text('Mô tả:')),
          Container(width: 390.w, child: Text(restaurant.description!)),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
