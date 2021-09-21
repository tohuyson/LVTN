import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/authservice.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/list_foods.dart';
import 'package:fooddelivery/screens/home/menu_screen.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:fooddelivery/model/item_category.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 184.h,
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: listItemCategory.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  print('tap tap');
                  print(listItemCategory[index].name!);
                  Get.to(MenuScreen(),
                      arguments: {'menuName': listItemCategory[index].name!});
                },
                child: Container(
                  height: 84.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xFFEFEFEF)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 40.h,
                        width: 40.w,
                        child: Image.asset('assets/icons_menu/' +
                            listItemCategory[index].url!),
                      ),
                      Container(
                        // height: 30.h,
                        child: Center(
                            child: Text(
                          listItemCategory[index].name!,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Food>> getRestaurants(String name) async {
    List<Food> list = [];
    String token = (await getToken())!;
    print(token);
    Map<String, String> queryParams = {
      'name': name,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    print(queryString);
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.searchFoodUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListFoods.fromJson(parsedJson).listFood!;
        return list;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return list;
  }
}
