import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/components/bottom_navigation_bar.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/discount.dart';
import 'package:fooddelivery/model/list_address.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/payment.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/order/components/delivery_item.dart';
import 'package:fooddelivery/screens/order/components/food_item.dart';
import 'package:fooddelivery/screens/order/components/list_address_delivery.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:fooddelivery/screens/order/order_screen.dart';
import 'package:fooddelivery/screens/restaurant/delivery.dart';
import 'package:fooddelivery/screens/restaurant/payment.dart';
import 'package:fooddelivery/screens/restaurant/voucher.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OrderDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderDetail();
  }
}

class _OrderDetail extends State<OrderDetail> {
  late Rx<Users> users;

  // late String address = '';
  late Rx<CardModel> card;

  late RxString person;
  late Rx<Discount> voucher;
  late RxString payment;
  late int card_id;
  late int delivery_fee;
  late double distance;

  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  String payResult = "";

  RxString a = ''.obs;
  String longitude = '';
  String latitude = '';

  @override
  void initState() {
    card = Rx<CardModel>(new CardModel());
    card_id = Get.arguments['card_id'];
    print('card_id $card_id');
    person = 'Vui lòng chọn'.obs;
    voucher = new Rx<Discount>(new Discount(name: '', image: '', percent: 0));
    payment = ''.obs;
    delivery_fee = 10000;
    distance = Get.arguments['distance'];
    print('khoảng cách ${distance}');

    if (Platform.isIOS) {
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    }
    getAd();
    super.initState();
  }

  Future<void> getAd() async {
    String? street = await getValue('street');
    String? add = await getValue('address');
    a = (street! + ', ' + add!).obs;

    longitude = (await getValue('longitude'))!;
    latitude = (await getValue('latitude'))!;
    print(a);
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
                                  () => Container(
                                    height: 52.h,
                                    width: 414.w,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 28.w,
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.black,
                                            size: 28.sp,
                                          ),
                                        ),
                                        Container(
                                          width: 328.w,
                                          padding: EdgeInsets.only(left: 10.w),
                                          height: 50.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 6.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      users.value.username!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    // Container(
                                                    //   width: 65.w,
                                                    //   padding: EdgeInsets.only(bottom: 4.h),
                                                    //   child: Row(
                                                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    //     children: [
                                                    //       Icon(
                                                    //         iconData_1,
                                                    //         size: 15.sp,
                                                    //       ),
                                                    //       Icon(
                                                    //         iconData_2,
                                                    //         size: 15.sp,
                                                    //       ),
                                                    //       Icon(
                                                    //         iconData_3,
                                                    //         size: 15.sp,
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // width: 348.w,
                                                child: Text(
                                                  a.value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 28.w,
                                          child: GestureDetector(
                                              onTap: () async {
                                                var result = await Get.to(
                                                    ListAddressDelivery());
                                                print(result);
                                                if (result != null) {
                                                  setState(() {
                                                    getAd();
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                size: 28.sp,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  //     DeliveryItem(
                                  //   iconData_4: Icons.edit,
                                  //   page: ListAddressDelivery(),
                                  //   deliveryModel: DeliveryModel(
                                  //       iconData: Icons.location_on,
                                  //       name: users.value.username,
                                  //       address: a.value),
                                  // ),
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
                                  // page: AddressScreen(),
                                  deliveryModel: DeliveryModel(
                                      iconData: Icons.timer_rounded,
                                      name: 'Thời giao hàng dự kiến',
                                      // address: 'Trong ${((distance / 5) * 60).round()} phút'),
                                      address: 'Trong ${timeDelivery()} phút'),
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
                        GestureDetector(
                          onTap: () async {
                            var result = await Get.to(() => Voucher(),
                                arguments: {
                                  'restaurant_id': card.value.restaurantId
                                });
                            print(result);
                            setState(() {
                              if (result != null) {
                                voucher.value = result;
                                voucher.refresh();
                              }
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
                        GestureDetector(
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
                        GestureDetector(
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
                                  '${NumberFormat.currency(locale: 'vi').format(card.value.sumPrice)}',
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
                                '${NumberFormat.currency(locale: 'vi').format(delivery_fee)}',
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
                                      '-${NumberFormat.currency(locale: 'vi').format(priceVocher().round())}',
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
                                '${NumberFormat.currency(locale: 'vi').format(sumPrice())}',
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
                          child: GestureDetector(
                            onTap: () async {
                              print('Thanh toán');
                              if (payment.value == 'Zalopay') {
                                var result = await createOrder(sumPrice());
                                String response = "";
                                try {
                                  final String r = await platform.invokeMethod(
                                      'payOrder',
                                      {"zptoken": result!.zptranstoken});
                                  response = r;
                                  print("payOrder Result: '$result'.");
                                } on PlatformException catch (e) {
                                  print("Failed to Invoke: '${e.message}'.");
                                  response = "Thanh toán thất bại";
                                }
                                print(response);
                                setState(() {
                                  if (response == 'Payment Success') {
                                    payResult = 'Thanh toán thành công';
                                    addOrder();
                                  } else
                                    payResult = response;
                                });
                                if (payResult != 'User Canceled') {
                                  // addOrder();
                                  showToast('Người dùng chưa thanh toán!');
                                }else
                                if (payResult != 'Payment failed') {
                                  // addOrder();
                                  showToast('Thanh toán thất bại!');
                                }
                              } else {
                                setState(() {
                                  payResult = ' Chưa thanh toán';
                                });
                                addOrder();
                              }
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

  void _onEvent(Object? event) {
    print("_onEvent: '$event'.");
    var res = Map<String, dynamic>.from(event as Map<String, dynamic>);
    setState(() {
      if (res["errorCode"] == 1) {
        payResult = "Thanh toán thành công";
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
      } else {
        payResult = "Giao dịch thất bại";
      }
    });
  }

  void _onError(Object error) {
    print("_onError: '$error'.");
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  double priceVocher() {
    return card.value.sumPrice! * (voucher.value.percent! / 100);
  }

  int sumPrice() {
    return card.value.sumPrice! + delivery_fee - priceVocher().round();
  }

  int timeDelivery() {
    return ((distance / 5) * 60).round();
  }

  Future<bool?> checkUser() async {
    await fetchCard();
    await fetchUser();

    // for (int i = 0; i < users.value.address!.length; i++) {
    //   if (users.value.address![i].status == 1) {
    //     print(users.value.address![i].address!);
    //     // address = users.value.address![i].address!;
    //   }
    // }
    return users.isBlank;
  }

  Future<void> fetchUser() async {
    var user = await getAddress();
    if (user != null) {
      users = user.obs;
    }
  }

  Future<Users?> getAddress() async {
    Users users;
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
        users = UsersJson.fromJson(parsedJson).users!;
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
    print(card_id);
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
    print(' trang thái  $payResult');
    EasyLoading.show();
    if (a.isNotEmpty) {
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
              'address': a.value,
              'price_delivery': delivery_fee,
              'note': note,
              'discount_id': discount_id,
              'card_id': card_id,
              'status': payResult,
              'latitude': latitude,
              'longitude': longitude,
              'time_delivery': timeDelivery(),
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

            var isNotify = await notification(
                order.food![0].restaurant!.user!.uid!,
                'Đơn hàng mới',
                'Bạn có một đơn hàng mới');
            if (isNotify == true) {
              await saveNotification(
                  'Đơn hàng mới',
                  'Bạn có một đơn hàng mới',
                  '${order.food![0].restaurant!.user!.id}',
                  1);
            }
            EasyLoading.dismiss();

            Get.off(
                BottomNavigation(
                  selectedIndex: 0,
                ),
                arguments: {'order_id': order.id});
          }
          if (response.statusCode == 204) {
            showToast("Bạn đang có một đang hàng đang giao, vui lòng mua hàng sau!");
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
    } else {
      showToast('Vui lòng Thêm địa chỉ giao hàng!');
    }
  }
}
