import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/home/components/menus.dart';
import 'package:fooddelivery/screens/home/components/slider_banner.dart';
import 'package:fooddelivery/screens/search/search_screens.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:http/http.dart' as http;

import 'components/restaurant_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  late RxList<Restaurant> restaurants;

  @override
  void initState() {
    restaurants = new RxList<Restaurant>();
    fetchRestaurants();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLoad(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: kPrimaryColorBackground,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(119.h),
                child: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(
                        left: 5.w, right: 0.w, bottom: 5.h, top: 5.h),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 30.h, bottom: 16.h, left: 12.w),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hôm nay, bạn ăn gì?',
                            style:
                                TextStyle(fontSize: 22.sp, color: Colors.white),
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
                width: 414.w,
                height: 834.h,
                child: RefreshIndicator(
                  onRefresh: () => fetchRestaurants(),
                  child: SingleChildScrollView(
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
                              itemCount: restaurants.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RestaurantItem(
                                  restaurant: restaurants[index],
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
          } else {
            return Container();
          }
        });
  }

  Future<bool> checkLoad() async {
    await fetchRestaurants();
    return restaurants.isNotEmpty;
  }

  Future<void> fetchRestaurants() async {
    var res = await getRestaurants();
    if (res != null) {
      restaurants.assignAll(res);
      restaurants.refresh();
    }
  }

  Future<List<Restaurant>?> getRestaurants() async {
    List<Restaurant> list;
    String token = (await getToken())!;
    print(token);
    Map<String, String> queryParams = {
      'limit': '40',
    };
    String queryString = Uri(queryParameters: queryParams).query;
    print(queryString);
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getRestaurantsUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListRestaurants.fromJson(parsedJson).listRestaurants!;
        list.sort((a, b) => (b.id!.compareTo(a.id!)));
        return list;
      }
      if (response.statusCode == 401) {
        showToast("Tải dữ liệu thất bại!");
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}

class LatestFeedsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 6.h, bottom: 6.h),
      child: Text(
        "Nhà hàng phổ biến",
        style: TextStyle(
            fontSize: 18.sp,
            color: Color(0xFF3a3a3b),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
