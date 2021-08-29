import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/restaurant_controller.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/topping.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class FoodRestaurant extends StatefulWidget {
  final List<Food?>? food;

  const FoodRestaurant({Key? key, this.food}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodRestaurant(
      food: food,
    );
  }
}

class _FoodRestaurant extends State<FoodRestaurant> {
  late List<Food?>? food;

  // var scrollViewColtroller = new ScrollController();

  _FoodRestaurant({
    this.food,
  });

  // late bool? isChecked;
  // late RxInt productCounter;
  //
  // late RxString title;
  // late List<int> listTopping;

  @override
  void initState() {
    // isChecked = false;
    // listTopping = [];
    // title = ''.obs;
    // productCounter = 1.obs;
    super.initState();
  }

  showAlert(context) {
    Alert(
        context: context,
        title: "Lưu ý",
        content: Container(
          width: 320.w,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              border: Border.all(color: kPrimaryColorBackground, width: 2)),
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.w),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: "Vd: không hành"),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Xác nhận",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  // late int food_id;
  // late int price_food;
  // late int restaurant_id;

  // showPicker(context, Food food) {
  //   setState(() {
  //     food_id = food.id!;
  //     price_food = food.price!;
  //     restaurant_id = food.restaurantId!;
  //     print(food_id);
  //     print(price_food);
  //
  //   });
  //   showCupertinoModalPopup(
  //       context: context,
  //       builder: (context) {
  //         return NotificationListener<ScrollUpdateNotification>(
  //           onNotification: (ScrollUpdateNotification scrollInfo) {
  //             if (scrollViewColtroller.position.userScrollDirection ==
  //                 ScrollDirection.reverse) {
  //               print('User is going down $title');
  //               setState(() {
  //                 title.value = food.name!;
  //               });
  //             } else {
  //               if (scrollViewColtroller.position.userScrollDirection ==
  //                   ScrollDirection.forward) {
  //                 print('User is going up');
  //                 setState(() {
  //                   title.value = '';
  //                 });
  //               }
  //             }
  //             return false;
  //           },
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: 818.h,
  //                 child: NestedScrollView(
  //                   controller: scrollViewColtroller,
  //                   headerSliverBuilder:
  //                       (BuildContext context, bool innerBoxIsScrolled) {
  //                     return <Widget>[
  //                       SliverAppBar(
  //                         elevation: 0,
  //                         expandedHeight: 200.h,
  //                         pinned: true,
  //                         title: Obx(() => Text(title.value)),
  //                         leading: BackButton(),
  //                         flexibleSpace: new FlexibleSpaceBar(
  //                           background: Image.network(
  //                             Apis.baseURL + food.images![0].url!,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     ];
  //                   },
  //                   body: Container(
  //                     color: Colors.white,
  //                     child: Card(
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                             padding: EdgeInsets.all(12.w),
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom: BorderSide(
  //                                         color: kPrimaryColorBackground,
  //                                         width: 8))),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Text(
  //                                   food.name!,
  //                                   softWrap: true,
  //                                   style: TextStyle(
  //                                       fontSize: 22.sp,
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                                 Text(
  //                                   food.price.toString(),
  //                                   style: TextStyle(
  //                                       fontSize: 22.sp,
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: [
  //                                 Container(
  //                                   padding: EdgeInsets.all(12.w),
  //                                   width: 414.w,
  //                                   child: Text(
  //                                     'Chọn Topping',
  //                                     style: TextStyle(fontSize: 18.sp),
  //                                   ),
  //                                 ),
  //                                 ListView.builder(
  //                                     shrinkWrap: true,
  //                                     physics: NeverScrollableScrollPhysics(),
  //                                     itemCount: food.toppings!.length,
  //                                     itemBuilder: (context, index) {
  //                                       return checkWidget(
  //                                           food.toppings![index]);
  //                                     }),
  //                                 Container(
  //                                   padding: EdgeInsets.only(top: 12.h),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: <Widget>[
  //                                       TextButton(
  //                                         onPressed: () {
  //                                           if (productCounter > 0) {
  //                                             setState(() {
  //                                               productCounter--;
  //                                             });
  //                                           }
  //                                         },
  //                                         child: Container(
  //                                           padding: EdgeInsets.all(5),
  //                                           decoration: BoxDecoration(
  //                                               border: Border.all(
  //                                                   color:
  //                                                       kPrimaryColorBackground,
  //                                                   width: 2)),
  //                                           child: Icon(
  //                                             Icons.remove,
  //                                             color: Theme.of(context)
  //                                                 .primaryColor,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       Container(
  //                                         width: 50.w,
  //                                         child: Center(
  //                                           child: Obx(
  //                                             () => Text(
  //                                               productCounter.value.toString(),
  //                                               style: new TextStyle(
  //                                                   fontSize: 18.sp,
  //                                                   color: Colors.black,
  //                                                   fontWeight:
  //                                                       FontWeight.w500),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       TextButton(
  //                                         onPressed: () {
  //                                           setState(() {
  //                                             productCounter++;
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                             padding: EdgeInsets.all(5),
  //                                             decoration: BoxDecoration(
  //                                                 border: Border.all(
  //                                                     color:
  //                                                         kPrimaryColorBackground,
  //                                                     width: 2)),
  //                                             child: Icon(
  //                                               Icons.add,
  //                                               color: Theme.of(context)
  //                                                   .primaryColor,
  //                                             )),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 height: 78.h,
  //                 width: 414.w,
  //                 color: Colors.white,
  //                 child: Card(
  //                   child: InkWell(
  //                     onTap: () async {
  //                      await addCardOrder();
  //                     },
  //                     child: Container(
  //                       margin: EdgeInsets.only(
  //                           top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
  //                       height: 45.h,
  //                       width: MediaQuery.of(context).size.width / 1.1,
  //                       decoration: BoxDecoration(
  //                           color: Theme.of(context).primaryColor,
  //                           borderRadius: BorderRadius.all(Radius.circular(5))),
  //                       child: Center(
  //                         child: Text(
  //                           'Thêm vào giỏ hàng',
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  // Widget checkWidget(Topping topping) {
  //   isChecked = false;
  //   listTopping = [];
  //   return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter mystate) {
  //     return Container(
  //       padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
  //       child: Card(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               child: Row(
  //                 children: [
  //                   Checkbox(
  //                     value: isChecked,
  //                     onChanged: (bool? value) {
  //                       mystate(() {
  //                         isChecked = value;
  //                         print(isChecked);
  //                         if (isChecked == true) {
  //                           print(topping.id);
  //                           listTopping.add(topping.id!);
  //                         }
  //                         if (isChecked == false) {
  //                           listTopping.remove(topping.id);
  //                         }
  //                         print(listTopping);
  //                       });
  //                     },
  //                   ),
  //                   Text(
  //                     topping.name!,
  //                     style: TextStyle(
  //                       fontSize: 16.sp,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(right: 12.w),
  //               child: Text(
  //                 '+' + topping.price.toString(),
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: food!.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 10.h,
              bottom: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: kPrimaryColorBackground),
              ),
            ),
            height: 102.h,
            child: Row(
              children: [
                Image.network(
                  Apis.baseURL + food![i]!.images![0].url!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
                Container(
                  width: 300.w,
                  padding: EdgeInsets.only(left: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food![i]!.name!,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '10+ đã bán',
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black38),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(NumberFormat.currency(locale: 'vi')
                          .format(food![i]!.price),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () async {
                              print('add');
                              var result = await Get.to(FoodDetail(
                                food: food![i],
                              ));
                              setState(() {
                                if (result != null) {}
                              });
                              // showPicker(context, food![i]!);
                            },
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class FoodDetail extends StatefulWidget {
  late Food? food;

  FoodDetail({this.food});

  @override
  State<StatefulWidget> createState() {
    return _FoodDetail(food: food);
  }
}

class _FoodDetail extends State<FoodDetail> {
  var scrollViewColtroller = new ScrollController();
  late bool? isChecked;
  late RxInt productCounter;

  late RxString title;
  late List<int> listTopping;
  late Food? food;

  late int food_id;
  late int price_food;
  late int restaurant_id;

  _FoodDetail({this.food});

  @override
  void initState() {
    listTopping = [];
    title = ''.obs;
    productCounter = 1.obs;
    food_id = food!.id!;
    price_food = food!.price!;
    restaurant_id = food!.restaurantId!;
    super.initState();
  }

  Widget checkWidget(Topping topping) {
    isChecked = false;
    listTopping = [];
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Container(
        padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        mystate(() {
                          isChecked = value;
                          print(isChecked);
                          if (isChecked == true) {
                            print(topping.id);
                            listTopping.add(topping.id!);
                          }
                          if (isChecked == false) {
                            listTopping.remove(topping.id);
                          }
                          print(listTopping);
                        });
                      },
                    ),
                    Text(
                      topping.name!,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 12.w),
                child: Text(
                  '+' + topping.price.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification scrollInfo) {
          if (scrollViewColtroller.position.userScrollDirection ==
              ScrollDirection.reverse) {
            print('User is going down $title');
            setState(() {
              title.value = food!.name!;
            });
          } else {
            if (scrollViewColtroller.position.userScrollDirection ==
                ScrollDirection.forward) {
              print('User is going up');
              setState(() {
                title.value = '';
              });
            }
          }
          return false;
        },
        child: Column(
          children: [
            Container(
              height: 818.h,
              child: NestedScrollView(
                controller: scrollViewColtroller,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      expandedHeight: 200.h,
                      pinned: true,
                      title: Obx(() => Text(title.value)),
                      leading: BackButton(),
                      flexibleSpace: new FlexibleSpaceBar(
                        background: Image.network(
                          Apis.baseURL + food!.images![0].url!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  color: Colors.white,
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: kPrimaryColorBackground,
                                      width: 8))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                food!.name!,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                food!.price.toString(),
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                width: 414.w,
                                child: Text(
                                  'Chọn Topping',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: food!.toppings!.length,
                                  itemBuilder: (context, index) {
                                    return checkWidget(food!.toppings![index]);
                                  }),
                              Container(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        if (productCounter > 0) {
                                          setState(() {
                                            productCounter--;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColorBackground,
                                                width: 2)),
                                        child: Icon(
                                          Icons.remove,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50.w,
                                      child: Center(
                                        child: Obx(
                                          () => Text(
                                            productCounter.value.toString(),
                                            style: new TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          productCounter++;
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      kPrimaryColorBackground,
                                                  width: 2)),
                                          child: Icon(
                                            Icons.add,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 78.h,
              width: 414.w,
              color: Colors.white,
              child: Card(
                child: InkWell(
                  onTap: () async {
                    await addCardOrder();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                    height: 45.h,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'Thêm vào giỏ hàng',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addCardOrder() async {
    String token = (await getToken())!;
    int price = productCounter.value * price_food;

    String toppingId = '';
    int priceTopping = 0;

    for (int i = 0; i < listTopping.length; i++) {
      for (int j = 0; j < food!.toppings!.length; j++) {
        if (food!.toppings![j].id == listTopping[i]) {
          priceTopping += food!.toppings![j].price! * productCounter.value;
        }
      }
      print('id topping lấy đc nè ${listTopping[i]}');

      if (i == listTopping.length - 1) {
        toppingId += listTopping[i].toString();
      } else {
        toppingId += listTopping[i].toString() + ",";
      }
    }
    print('topping $toppingId');
    print(priceTopping);
    price = price + priceTopping;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postAddCardUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'quantity': productCounter.value.toString(),
          'food_id': food_id.toString(),
          'price': price.toString(),
          'toppingid': toppingId,
          'restaurant_id': restaurant_id.toString(),
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        var parsedJson = jsonDecode(response.body);
        // print(parsedJson['card']);
        CardModel card = CardJson.fromJson(parsedJson).card!;
        Get.back(result: card);
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
