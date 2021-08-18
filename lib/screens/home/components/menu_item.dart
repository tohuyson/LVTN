import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/item_category.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuItem();
  }
}

class _MenuItem extends State<MenuItem> {
  late ItemCategory itemCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(itemCategory.name!),
      ),
      body: Container(
        color: kPrimaryColorBackground,
        child: GestureDetector(
          onTap: () {
            // Get.to(RestaurantsScreen(),);
          },
          child: Container(
            width: 414.w,
            color: Colors.white,
            padding:
                EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
            margin:
                EdgeInsets.only(bottom: 4.h, top: 4.h, left: 12.w, right: 12.w),
            height: 96.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  ' Apis.baseURL + restaurant.image!',
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          ' restaurant.name!',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('restaurant.rating!'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
