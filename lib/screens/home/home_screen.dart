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
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/screens/search/search_screens.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  late RxList<Foods> foods;
  late double startLat;
  late double startLong;

  @override
  void initState() {
    restaurants = new RxList<Restaurant>();
    foods = new RxList<Foods>();
    // fetchRestaurants();
    // fetchFood();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLoad(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
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
                              style: TextStyle(
                                  fontSize: 22.sp, color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 42.h,
                            width: 386.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.to(SearchScreen());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: kPrimaryColorBackground)),
                            ),
                            width: 414.w,
                            padding: EdgeInsets.only(
                                left: 12.w, right: 12.w, top: 6.h, bottom: 6.h),
                            child: Text(
                              "Món ăn bán chạy",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 232.h,
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 12.w, right: 12.w, top: 6.h, bottom: 6.h),
                            child: Obx(
                              () => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  // primary: false,
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: foods.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(RestaurantsScreen(), arguments: {
                                          'restaurant_id':
                                              foods[index].restaurantId
                                        });
                                      },
                                      child: Container(
                                        width: 120.w,
                                        margin: EdgeInsets.only(
                                            right: 5.w, left: 5.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColorBackground,
                                                width: 1)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2)),
                                              child: Image.network(
                                                Apis.baseURL +
                                                    foods[index].url!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                foods[index].name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.w,
                                                  right: 5.w,
                                                  bottom: 4.h),
                                              child: Text(
                                                  '${NumberFormat.currency(locale: 'vi').format(foods[index].price!)}'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
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
                                    startLat: startLat,
                                    startLong: startLong,
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
          }
        });
  }

  Future<bool> checkLoad() async {
    String? latitude = await getValue('latitude');
    String? longitude = await getValue('longitude');
    print(latitude);
    print(longitude);

    startLat = double.parse(latitude!);
    startLong = double.parse(longitude!);
    await fetchRestaurants();
    await fetchFood();
    return restaurants.isNotEmpty;
  }

  Future<void> fetchRestaurants() async {
    var res = await getRestaurants();
    if (res != null) {
      restaurants.assignAll(res);
      restaurants.refresh();
    }
  }

  Future<void> fetchFood() async {
    var f = await getFood();
    print(' đồ ăn nè ${f!.length}.');
    if (f != null) {
      foods.assignAll(f);
      foods.refresh();
    }
  }

  Future<List<Foods>?> getFood() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.listFoodHomeUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var list = ListFoodHome.fromJson(parsedJson).foods;
        return list;
      }
      if (response.statusCode == 204) {
        return new List.empty();
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

class ListFoodHome {
  List<Foods>? foods;

  ListFoodHome({this.foods});

  ListFoodHome.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List.generate(0, (index) => new Foods());
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? name;
  int? price;
  String? url;
  int? restaurantId;
  int? totalFood;

  Foods({this.name, this.price, this.url, this.restaurantId, this.totalFood});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    url = json['url'];
    restaurantId = json['restaurant_id'];
    totalFood = json['total_food'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['url'] = this.url;
    data['restaurant_id'] = this.restaurantId;
    data['total_food'] = this.totalFood;
    return data;
  }
}
