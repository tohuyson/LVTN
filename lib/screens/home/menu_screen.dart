import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuScreen();
  }
}

class _MenuScreen extends State<MenuScreen> {
  late String menuName;
  late RxList<Restaurant> listRestaurant;

  @override
  void initState() {
    menuName = Get.arguments['menuName'];
    listRestaurant = new RxList<Restaurant>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${menuName}'),
      ),
      body: FutureBuilder(
        future: fetchRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            if (snapshot.hasData) {
              return listRestaurant.length > 0
                  ? Obx(
                      () => ListView.builder(
                        itemCount: listRestaurant.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(RestaurantsScreen(), arguments: {
                                'restaurant_id': listRestaurant[index].id
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 414.w,

                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 8.h,
                                  bottom: 8.h),
                              margin: EdgeInsets.only(
                                  bottom: 4.h,
                                  top: 4.h,
                                  left: 12.w,
                                  right: 12.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          Apis.baseURL +
                                              listRestaurant[index].image!,
                                          width: 80.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 12.w),
                                        height: 80.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                listRestaurant[index].name!,
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.amber,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(listRestaurant[index]
                                                    .rating!),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : EmptyScreen(text: 'Không có kết quả tìm kiếm!');
            } else {
              return EmptyScreen(text: 'Không có kết quả tìm kiếm!');
            }
          }
        },
      ),
    );
  }

  Future<bool> fetchRestaurant() async {
    var res = await getRestaurants();
    if (res != null) {
      listRestaurant.assignAll(res);
      listRestaurant.refresh();
    }
    return listRestaurant.isNotEmpty;
  }

  Future<List<Restaurant>?> getRestaurants() async {
    List<Restaurant> list;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'name': menuName,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.searchRestaurantUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListRestaurants.fromJson(parsedJson).listRestaurants!;
        return list;
      }
      if (response.statusCode == 204) {
        return new List.empty();
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}
