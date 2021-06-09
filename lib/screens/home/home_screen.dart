import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/screens/home/components/menus.dart';
import 'package:fooddelivery/screens/home/components/popular_food.dart';
import 'package:fooddelivery/screens/home/components/slider_banner.dart';
import 'package:fooddelivery/screens/search/search_screens.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(119.h),
        child: AppBar(
          // backflutter pub global run devtools   # If you have `flutter` on your path.groundColor: Theme.of(context).primaryColor,
          flexibleSpace: Padding(
            padding:
                EdgeInsets.only(left: 5.w, right: 0.w, bottom: 5.h, top: 5.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30.h, bottom: 16.h, left: 12.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hôm nay, bạn ăn gì?',
                    style: TextStyle(fontSize: 22.sp, color: Colors.white),
                  ),
                ),
                Container(
                  height: 42.h,
                  width: 386.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(SearchScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tìm nhà hàng món ăn',
                          style: TextStyle(color: Colors.black38),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 834.h,
        child: ListView(
          // shrinkWrap: true,
          children: [
            SlideBannerWidget(),
            Menu(),
            PopularFood(),
          ],
        ),
      ),
    );
  }
}
