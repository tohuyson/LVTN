import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/search/components/search_begin.dart';
import 'package:fooddelivery/screens/search/components/search_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
  List<Food>? foods;
  late TextEditingController controller = TextEditingController();
  late RxList<Restaurant> listRestaurant;
  bool isLoading = false;

  // Widget buildSearch() => SearchWidget(
  //       text: query,
  //       focus: true,
  //       hintText: 'Tìm nhà hàng món ăn',
  //       onChanged: searchFood,
  //     );

  // void searchFood(String query) {
  //   print(query);
  //   // final foods = listFoodOrder.values.where((food) {
  //   //   final titleLower = food.name!.toLowerCase();
  //   //   final searchLower = query.toLowerCase();
  //   //
  //   //   return titleLower.contains(searchLower);
  //   // }).toList();
  //
  //   setState(() {
  //     print('vào');
  //     this.query = query;
  //     this.foods = foods;
  //
  //     body = SearchBody(
  //       foods: foods,
  //     );
  //   });
  // }

  @override
  void initState() {
    listRestaurant = new RxList<Restaurant>();
    super.initState();
  }

  // Widget buildBody() {
  //   setState(() {
  //     _controller.text.isEmpty
  //         ? SearchBegin()
  //         : SearchBody(
  //             foods: foods,
  //           );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45.h,
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            onChanged: (value) async {
              var r = await getRestaurants(value);
              print(r);
              setState(() {
                print(r!.length);
                listRestaurant.assignAll(r);
                listRestaurant.refresh();
                isLoading = false;
              });
            },
            decoration: InputDecoration(
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              fillColor: Colors.white,
              suffixIcon: controller.text.isNotEmpty || controller.text != ''
                  ? GestureDetector(
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onTap: () {
                        controller.clear();
                        // widget.onChanged!('');
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
                  : GestureDetector(
                      child: Icon(Icons.search, color: Colors.black45),
                      onTap: () async {
                        // controller.clear();
                        // widget.onChanged!('');
                        print(controller.text);
                        var r = await getRestaurants(controller.text);
                        setState(() {
                          print(r!.length);
                          listRestaurant.assignAll(r);
                          listRestaurant.refresh();
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
              hintText: 'Tìm kiếm nhà hàng',
              hintStyle: new TextStyle(
                color: Colors.black38,
                fontSize: 16.sp,
              ),
              contentPadding: EdgeInsets.all(15),
            ),
            // onChanged: widget.onChanged,
          ),
        ),
      ),
      body: Stack(
        children: [
          controller.text.isNotEmpty
              ? Obx(
                  () => listRestaurant.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 12.w,
                                  top: 8.w,
                                  bottom: 8.w),
                              child: Text(
                                'Bạn đang tìm kiếm nhà hàng, món ăn?',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                            Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Cơm'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Cơm');
                                      var r =
                                          await getRestaurants(controller.text);
                                      setState(() {
                                        print(r!.length);
                                        listRestaurant.assignAll(r);
                                        listRestaurant.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('DVC Cơm sinh viên'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'DVC Cơm sinh viên');
                                      var r =
                                          await getRestaurants(controller.text);
                                      setState(() {
                                        print(r!.length);
                                        listRestaurant.assignAll(r);
                                        listRestaurant.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Cơm Chiên sườn'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Cơm Chiên sườn');
                                      var r =
                                          await getRestaurants(controller.text);
                                      setState(() {
                                        print(r!.length);
                                        listRestaurant.assignAll(r);
                                        listRestaurant.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Bún'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Bún');
                                      var r =
                                          await getRestaurants(controller.text);
                                      setState(() {
                                        print(r!.length);
                                        listRestaurant.assignAll(r);
                                        listRestaurant.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                      label: Text('Hủ tiếu'),
                                      onPressed: () async {
                                        controller = new TextEditingController(
                                            text: 'Hủ tiếu');
                                        var r = await getRestaurants(
                                            controller.text);
                                        setState(() {
                                          print(r!.length);
                                          listRestaurant.assignAll(r);
                                          listRestaurant.refresh();
                                          isLoading = false;
                                        });
                                      }),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Bánh canh'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Bánh canh');
                                      var r =
                                          await getRestaurants(controller.text);
                                      setState(() {
                                        print(r!.length);
                                        listRestaurant.assignAll(r);
                                        listRestaurant.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          height: 834.h,
                          child: ListView.builder(
                              itemCount: listRestaurant.length,
                              itemBuilder: (context, index) {
                                return SearchBody(
                                  restaurant: listRestaurant[index],
                                );
                              }),
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 24.w, right: 12.w, top: 8.w, bottom: 8.w),
                      child: Text(
                        'Bạn đang tìm kiếm nhà hàng, món ăn?',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Cơm'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Cơm');
                              var r = await getRestaurants(controller.text);
                              setState(() {
                                print(r!.length);
                                listRestaurant.assignAll(r);
                                listRestaurant.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('DVC Cơm sinh viên'),
                            onPressed: () async {
                              controller = new TextEditingController(
                                  text: 'DVC Cơm sinh viên');
                              var r = await getRestaurants(controller.text);
                              setState(() {
                                print(r!.length);
                                listRestaurant.assignAll(r);
                                listRestaurant.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Cơm Chiên sườn'),
                            onPressed: () async {
                              controller = new TextEditingController(
                                  text: 'Cơm Chiên sườn');
                              var r = await getRestaurants(controller.text);
                              setState(() {
                                print(r!.length);
                                listRestaurant.assignAll(r);
                                listRestaurant.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Bún'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Bún');
                              var r = await getRestaurants(controller.text);
                              setState(() {
                                print(r!.length);
                                listRestaurant.assignAll(r);
                                listRestaurant.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                              label: Text('Hủ tiếu'),
                              onPressed: () async {
                                controller =
                                    new TextEditingController(text: 'Hủ tiếu');
                                var r = await getRestaurants(controller.text);
                                setState(() {
                                  print(r!.length);
                                  listRestaurant.assignAll(r);
                                  listRestaurant.refresh();
                                  isLoading = false;
                                });
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Bánh canh'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Bánh canh');
                              var r = await getRestaurants(controller.text);
                              setState(() {
                                print(r!.length);
                                listRestaurant.assignAll(r);
                                listRestaurant.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          isLoading
              ? Center(
                  child: Container(
                      width: 50.w,
                      height: 50.h,
                      color: Colors.transparent,
                      child: const Loading()),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<List<Restaurant>?> getRestaurants(String name) async {
    List<Restaurant> list;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'name': name,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    print(queryString);
    setState(() {
      isLoading = true;
    });
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.searchRestaurantUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListRestaurants.fromJson(parsedJson).listRestaurants!;
        return list;
      }
      if (response.statusCode == 204) {
        // var parsedJson = jsonDecode(response.body);
        // list = ListRestaurants.fromJson(parsedJson).listRestaurants!;
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
