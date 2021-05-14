import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/components/food_card.dart';
import 'package:fooddelivery/components/menus.dart';
import 'package:fooddelivery/components/slider_banner.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/screens/latest_feeds.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  final int selectedIndex;

  HomeScreen(this.selectedIndex);

  ScrollController _scrollController = new ScrollController();

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
          SlideBanner(),
          Menu(),
          LatestFeeds(),
        ],
      ),
    );
  }
}
