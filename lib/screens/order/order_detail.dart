import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/discount.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/order/components/delivery_item.dart';
import 'package:fooddelivery/screens/order/components/food_item.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/restaurant/delivery.dart';
import 'package:fooddelivery/screens/restaurant/payment.dart';
import 'package:fooddelivery/screens/restaurant/voucher.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderDetail();
  }
}

class _OrderDetail extends State<OrderDetail> {
  late Rx<Users> users;
  late String address = '';
  late Rx<CardModel> card;

  late RxString person;
  late Rx<Discount> voucher;
  late RxString payment;
  late int card_id;
  late int delivery_fee;

  @override
  void initState() {
    card_id = Get.arguments['card_id'];
    print('card_id $card_id');
    person = 'Vui lòng chọn'.obs;
    voucher = new Rx<Discount>(new Discount(name: '', image: '', percent: 0));
    payment = ''.obs;
    delivery_fee = 10000;
    // checkUser();
    // users =  getAddress();
    RxStatus.loading();
    fetchUser();
    fetchCard();
    super.initState();
  }

  final myController = TextEditingController();
  String note = 'Chưa có';

  showPicker() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xff999999),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Hủy',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                          myController.clear();
                        },
                      ),
                      Text(
                        'Thêm ghi chú',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        child: Text(
                          'Xong',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        onPressed: () {
                          setState(() {
                            note = myController.text;
                            myController.clear();
                            Get.close(1);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 250.0,
                  color: Color(0xfff7f7f7),
                  padding: EdgeInsets.only(
                      left: 24.w, right: 24.w, top: 12.h, bottom: 12.w),
                  child: TextField(
                    controller: myController,
                    maxLines: 4,
                    decoration:
                        InputDecoration.collapsed(hintText: "Nhập ghi chú"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: checkUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 834.h,
                width: 414.w,
                child: ListView(
                  addAutomaticKeepAlives: true,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 8,
                                      color: kPrimaryColorBackground))),
                          child: Column(
                            children: [
                              Container(
                                width: 414.w,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Giao tới',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: kPrimaryColorBackground,
                                            width: 2))),
                                padding: EdgeInsets.only(
                                    left: 12.w, right: 12.w, bottom: 4.h),
                                child: Obx(
                                  () => DeliveryItem(
                                    iconData_4: Icons.edit,
                                    page: AddressScreen(),
                                    deliveryModel: DeliveryModel(
                                        iconData: Icons.location_on,
                                        name: users.value.username,
                                        address: address),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: kPrimaryColorBackground,
                                            width: 2))),
                                padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 12.w,
                                    bottom: 4.h,
                                    top: 8.h),
                                child: DeliveryItem(
                                  page: AddressScreen(),
                                  deliveryModel: DeliveryModel(
                                      iconData: Icons.timer_rounded,
                                      name: 'Thời giao hàng dự kiến',
                                      address: 'Trong 20 phút'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: kPrimaryColorBackground,
                                      width: 8))),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                width: 414.w,
                                child: Text(
                                  'Đơn hàng',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              FoodItem(
                                cardModel: card.value,
                              ),
                            ],
                          ),
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     var result = await Get.to(() => Delivery());
                        //     print(result);
                        //     setState(() {
                        //       person = result;
                        //     });
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         border: Border(
                        //             bottom: BorderSide(
                        //                 width: 2,
                        //                 color: kPrimaryColorBackground))),
                        //     padding: EdgeInsets.all(12.w),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           'Giao hàng',
                        //           style: TextStyle(
                        //             fontSize: 18.sp,
                        //           ),
                        //         ),
                        //         Row(
                        //           children: [
                        //             Obx(
                        //               () => Text(
                        //                 person.value,
                        //                 style: TextStyle(
                        //                     fontSize: 16.sp,
                        //                     color: Colors.black38),
                        //               ),
                        //             ),
                        //             Icon(
                        //               Icons.arrow_forward_ios_outlined,
                        //               size: 16.sp,
                        //             ),
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () async {
                            var result = await Get.to(() => Voucher(),
                                arguments: {
                                  'restaurant_id': card.value.restaurantId
                                });
                            print(result);
                            setState(() {
                              voucher.value = result;
                              voucher.refresh();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: kPrimaryColorBackground))),
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Khuyến mãi',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        // width: 150.w,
                                        height: 30.h,
                                        padding: EdgeInsets.only(
                                            left: 16.sp, right: 16.sp),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                        ),

                                        child: Text(
                                          voucher.value.percent == 0
                                              ? 'Chọn voucher'
                                              : 'Mã giảm ${voucher.value.percent}%',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black38),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var result = await Get.to(Payment());
                            setState(() {
                              payment = result;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: kPrimaryColorBackground))),
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phương thức thanh toán',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      payment.value == ''
                                          ? 'Vui lòng chọn'
                                          : payment.value,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black38),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 16.sp,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showPicker();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: kPrimaryColorBackground))),
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lưu ý',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      note,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black38),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 16.sp,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2,
                                      color: kPrimaryColorBackground))),
                          padding: EdgeInsets.all(12.w),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng (${card.value.cardOrder!.length} phần)',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Text(
                                  '${card.value.sumPrice}đ',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2,
                                      color: kPrimaryColorBackground))),
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phí giao hàng',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                '$delivery_feeđ',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        voucher.value.name!.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: kPrimaryColorBackground))),
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Mã khuyến mãi',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      '-${priceVocher().round()}đ',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2,
                                      color: kPrimaryColorBackground))),
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tổng cộng',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                '${sumPrice()}đ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 98.h,
                          width: 414.w,
                          color: Colors.white,
                          padding: EdgeInsets.all(12.w),
                          child: InkWell(
                            onTap: () {
                              print('Thanh toán');
                              addOrder();
                            },
                            child: Container(
                              height: 46.h,
                              margin: EdgeInsets.only(
                                top: 20.h,
                              ),
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  'Thanh toán',
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  double priceVocher() {
    return card.value.sumPrice! * (voucher.value.percent! / 100);
  }

  int sumPrice() {
    return card.value.sumPrice! + delivery_fee - priceVocher().round();
  }

  Future<bool?> checkUser() async {
    await fetchUser();

    await fetchCard();

    for (int i = 0; i < users.value.address!.length; i++) {
      if (users.value.address![i].status == 1) {
        print(users.value.address![i].address!);
        address = users.value.address![i].address!;
      }
    }

    return users.isBlank;
  }

  Future<void> fetchUser() async {
    var user = await getAddress();
    if (user != null) {
      users = user.obs;
    }
  }

  Future<Users?> getAddress() async {
    Users users = new Users();
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getAddressUrl1),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        // listAddress.assignAll(ListAddress.fromJson(parsedJson).listAddress!);
        // listAddress.refresh();
        users = UsersJson.fromJson(parsedJson).users!;
        // print(listAddress);
        print(users.username);
        return users;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }

  Future<void> fetchCard() async {
    var c = await getCard();
    if (c != null) {
      card = c.obs;
    }
  }

  Future<CardModel?> getCard() async {
    CardModel card = new CardModel();
    String token = (await getToken())!;
    try {
      Map<String, String> queryParams = {
        'card_id': card_id.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      http.Response response = await http.get(
        Uri.parse(Apis.getCardOrderUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        card = CardJson.fromJson(parsedJson).card!;
        print(card);
        return card;
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }

  Future<void> addOrder() async {
    var token = await getToken();
    if (payment.value.isNotEmpty) {
      try {
        int sumprice = sumPrice();
        int discount_id;
        if (voucher.value.id == null) {
          discount_id = 0;
        } else {
          discount_id = voucher.value.id!;
        }
        print(sumprice);
        print(payment.value);
        int card_id = card.value.id!;
        http.Response response = await http.post(
          Uri.parse(Apis.postOrderUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode(<String, dynamic>{
            'sumprice': sumprice,
            'method_payment': payment.value,
            'address': address,
            'price_delivery': delivery_fee,
            'note': note,
            'discount_id': discount_id,
            'card_id': card_id,
          }),
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var parsedJson = jsonDecode(response.body);
          // print(parsedJson['order']);
          // showToast('Mua hàng thành công');
          Order order = OrderJson.fromJson(parsedJson).order!;

          print(order);

          print(order.food![0].restaurant!.user!.uid!);

         await notification(order.food![0].restaurant!.user!.uid!, 'Đơn hàng mới',
              'Bạn có một đơn hàng mới');

          Get.off(
              BottomNavigation(
                selectedIndex: 0,
              ),
              arguments: {'order_id': order.id});
        }
        if (response.statusCode == 500) {
          showToast("Hệ thống bị lỗi, Vui lòng thử lại sau!");
        }
      } on TimeoutException catch (e) {
        showError(e.toString());
      } on SocketException catch (e) {
        showError(e.toString());
        print(e.toString());
      }
    } else {
      showToast('Vui lòng chọn phương thức thanh toán!');
    }
  }
}
