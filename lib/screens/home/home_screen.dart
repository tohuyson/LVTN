import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/screens/home/components/menus.dart';
import 'package:fooddelivery/screens/home/components/slider_banner.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'components/restaurant_item.dart';

class HomeScreen extends GetWidget<HomeController> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(119.h),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
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
                      // Get.to(SearchScreen());
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
        child: RefreshIndicator(
          onRefresh: () => controller.fetchRestaurants(),
          child: SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                SlideBannerWidget(),
                Menu(),
                LatestFeedsTitle(),
                Obx(
                  () => LazyLoadScrollView(
                    onEndOfPage: () => controller.nextPage(),
                    isLoading: controller.lastPage,
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.listRestaurants.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RestaurantItem(
                          restaurant: controller.listRestaurants[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LatestFeedsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.h, bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Thức ăn phổ biến",
            style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
