import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/card_oder.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/order/order_detail.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'component/food_restaurant.dart';

class ListFoodRestaurant extends StatefulWidget {
  final Restaurant restaurant;
  final double distance;

  ListFoodRestaurant({required this.restaurant, required this.distance});

  @override
  State<StatefulWidget> createState() {
    return _ListFoodRestaurant(restaurant: restaurant, distance: distance);
  }
}

class _ListFoodRestaurant extends State<ListFoodRestaurant> {
  final Restaurant restaurant;
  final double distance;

  _ListFoodRestaurant({required this.restaurant, required this.distance});

  late Rx<CardModel> card;

  @override
  void initState() {
    card = Rx<CardModel>(new CardModel());
    fetchCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: restaurant.foods!.length,
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
                    Apis.baseURL + restaurant.foods![i].images![0].url!,
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
                          restaurant.foods![i].name!,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            restaurant.foods![i].discountId == null
                                ? Text(
                                    'Giá : ${NumberFormat.currency(locale: 'vi').format(restaurant.foods![i].price)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                          'Giá :  ${NumberFormat.currency(locale: 'vi').format((restaurant.foods![i].price! - restaurant.foods![i].price! * (double.parse(restaurant.foods![i].discount!.percent!) / 100)).round())}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '${NumberFormat.currency(locale: 'vi').format(restaurant.foods![i].price)}',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ],
                                  ),
                            GestureDetector(
                              onTap: () async {
                                var result = await Get.to(FoodDetail(
                                  food: restaurant.foods![i],
                                ));
                                if (result != null) {
                                  await fetchCard();
                                  // });
                                }
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
          }),
      floatingActionButton: FutureBuilder(
          future: fetchCard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              if (snapshot.hasError) {
                return Container();
              } else {
                return card.value.id != null
                    ? FloatingActionButton.extended(
                        onPressed: () {},
                        label: Container(
                          height: 76.h,
                          width: 414.w,
                          color: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 16.h,
                                  left: 16.w,
                                  right: 16.w),
                              height: 50.h,
                              width: 382.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _modalBottomSheetMenu();
                                    },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: Colors.black,
                                              size: 34.sp,
                                            ),
                                          ),
                                          Positioned(
                                            left: 18.w,
                                            top: 2.h,
                                            child: Container(
                                              width: 20.w,
                                              height: 20.h,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Text(
                                                '${card.value.cardOrder!.length}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(card.value.sumPrice),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(OrderDetail(), arguments: {
                                            'card_id': card.value.id,
                                            'distance': distance
                                          });
                                        },
                                        child: Container(
                                          height: 46.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              'Đặt hàng',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      )
                    : Container();
              }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  bool isLoading = false;

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 600.h,
              child: Wrap(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await deleteCard();
                                    },
                                    child: Text(
                                      'Xóa hết',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Giỏ hàng',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      Get.back();
                                    },
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.black12, width: 1))),
                            ),
                          ),
                          Container(
                            height: 538.h,
                            child: ListView.builder(
                                itemCount: card.value.cardOrder!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 12.w,
                                        right: 12.w,
                                        top: 8.h,
                                        bottom: 8.h),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          Apis.baseURL +
                                              card.value.cardOrder![index].food!
                                                  .images![0].url!,
                                          fit: BoxFit.cover,
                                          width: 80.w,
                                          height: 80.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 12.w),
                                          width: 310.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 298.w,
                                                child: Text(
                                                  '${card.value.cardOrder![index].food!.name}',
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                height: 50.h,
                                                width: 298.w,
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: card
                                                        .value
                                                        .cardOrder![index]
                                                        .toppings!
                                                        .length,
                                                    itemBuilder: (context, i) {
                                                      return Row(
                                                        children: [
                                                          Text(
                                                            '${card.value.cardOrder![index].toppings![i].name}',
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .black38),
                                                          ),
                                                          card
                                                                          .value
                                                                          .cardOrder![
                                                                              index]
                                                                          .toppings!
                                                                          .length -
                                                                      1 !=
                                                                  i
                                                              ? Text(', ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .black38))
                                                              : Text(''),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(card
                                                            .value
                                                            .cardOrder![index]
                                                            .price)),
                                                    Container(
                                                      width: 100.w,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () async {
                                                              var cardOrder =
                                                                  await decreaseQuantity(card
                                                                      .value
                                                                      .cardOrder![
                                                                          index]
                                                                      .id!);
                                                              setState(() {
                                                                card.value.cardOrder![
                                                                        index] =
                                                                    cardOrder!;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(3),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color:
                                                                          kPrimaryColorBackground,
                                                                      width:
                                                                          1)),
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                size: 16.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 40.w,
                                                            child: Center(
                                                              child: Text(
                                                                '${card.value.cardOrder![index].quantity}',
                                                                style: new TextStyle(
                                                                    fontSize:
                                                                        18.sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              var cardOrder =
                                                                  await increaseQuantity(card
                                                                      .value
                                                                      .cardOrder![
                                                                          index]
                                                                      .id!);
                                                              setState(() {
                                                                card.value.cardOrder![
                                                                        index] =
                                                                    cardOrder!;
                                                              });
                                                            },
                                                            child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                  color:
                                                                      kPrimaryColorBackground,
                                                                  width: 1,
                                                                )),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 16.sp,
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
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      Positioned.fill(
                          child: isLoading ? const Loading() : Container())
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> deleteCard() async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.deleteCardUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'cart_id': card.value.id,
        }),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Get.back();
        var c = await getCard(restaurant.id!);
        if (c == null) {
          setState(() {
            card = new CardModel().obs;
          });
        }
      }
      if (response.statusCode == 401) {
        showToast("Xóa không thành công!");
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

  Future<CardOrder?> increaseQuantity(int cardOrderId) async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.increaseQuantityUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'cardOrderId': cardOrderId,
        }),
      );

      if (response.statusCode == 200) {

        var parsedJson = jsonDecode(response.body);
        CardOrder? cardOrder = CardOrderJson.fromJson(parsedJson).cardOrder;
        var c = await getCard(restaurant.id!);
        if (c != null) {
          setState(() {
            card = c.obs;
          });
        }
        return cardOrder;
      }
      if (response.statusCode == 401) {
        showToast("Thực hiện tăng số lượng không thành công!");
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

  Future<CardOrder?> decreaseQuantity(int cardOrderId) async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.decreaseQuantityUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'cardOrderId': cardOrderId,
        }),
      );

      if (response.statusCode == 200) {

        var parsedJson = jsonDecode(response.body);
        CardOrder? cardOrder = CardOrderJson.fromJson(parsedJson).cardOrder;
        var c = await getCard(restaurant.id!);
        if (c != null) {
          setState(() {
            card = c.obs;
          });
        }
        return cardOrder;
      }
      if (response.statusCode == 401) {
        showToast("Thực hiện tăng số lượng không thành công!");
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

  Future<void> fetchCard() async {
    var c = await getCard(restaurant.id!);
    if (c != null) {
      card = c.obs;
    }
  }

  Future<CardModel?> getCard(int restaurant_id) async {
    var token = await getToken();
    Map<String, String> queryParams = {
      'restaurant_id': restaurant_id.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getCardUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        CardModel card = CardJson.fromJson(parsedJson).card!;
        return card;
      }
      if (response.statusCode == 401) {
        card = new CardModel().obs;
        return card.value;
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
