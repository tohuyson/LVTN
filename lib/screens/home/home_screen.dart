import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/home/slider_banner.dart';

import 'latest_feeds.dart';
import 'menus.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          // backgroundColor: Theme.of(context).primaryColor,
          title: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 0.w, bottom: 5.h, top: 5.h),
            child: Column(
              children: [
                Container(
                  height: 35.h,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black26,
                        ),
                        hintStyle: new TextStyle(
                            color: Colors.black38, fontSize: 14.sp),
                        hintText: "Tìm quán ăn, món ăn",
                        contentPadding: EdgeInsets.all(10.h)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: IconButton(
                  icon: Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                    size: 32.h,
                  ),
                  onPressed: () {
                    print("Thông báo");
                  }),
            )
          ],
        ),
      ),
      body: ListView(
        // shrinkWrap: true,
        children: [
          SlideBannerWidget(),
          Menu(),
          LatestFeeds(),
        ],
      ),
    );
  }
}
