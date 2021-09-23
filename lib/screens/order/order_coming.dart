import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_map.dart';
import 'package:fooddelivery/screens/profile/information_user.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../apis.dart';
import '../../utils.dart';
import '../widget/empty_screen.dart';

class OrderComing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderDetail();
}

class _OrderDetail extends State<OrderComing> {
  int _index = 0;
  bool isLoading = false;
  late Rx<Order> order;
  late TextEditingController reason;

  Future<void> checkPermision() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    reason = new TextEditingController();
    checkPermision();
    order = new Rx(new Order());
    fetchOrder();
    super.initState();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            if (snapshot.hasError) {
              return EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
            } else {
              return order.value.id != null
                  // && order.value.orderStatusId != 5 &&
                  //     order.value.orderStatusId != 4
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          DeliveryMap(
                            height: 280,
                            restaurant: order.value.food![0].restaurant!,
                            order: order.value,
                          ),
                          Container(
                            // height: 450.h,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10.w,
                                    right: 10.w,
                                    top: 6.h,
                                  ),
                                  padding: EdgeInsets.only(
                                      bottom: 6.h, left: 5.w, right: 5.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.black12))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(
                                        'Đồ ăn',
                                        style: TextStyle(fontSize: 16.sp),
                                      )),
                                      Container(
                                          child: Text(
                                        'Đang đến trong ${order.value.time_delivery} phút',
                                        style: TextStyle(fontSize: 16.sp),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 6.h, left: 10.w, right: 10.w),
                                  padding: EdgeInsets.only(
                                      bottom: 6.h, left: 5.w, right: 5.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.black12))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 290.w,
                                        // height: 65.h,
                                        padding: EdgeInsets.only(
                                            top: 4.h, bottom: 4.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.value.food![0].restaurant!
                                                  .name!,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // SizedBox(
                                            //   height: 4.h,
                                            // ),
                                            Text(
                                              'Tổng: ${NumberFormat.currency(locale: 'vi').format(order.value.price)}',
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 1,
                                            ),
                                            Text(
                                                'Thanh toán: ${order.value.payment!.method! + ' - ' + order.value.payment!.status!}'),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    title: Text(
                                                        'Chi tiết đơn hàng'),
                                                    content: Container(
                                                      width: 414.w,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: order
                                                                .value
                                                                .food!
                                                                .length,
                                                            itemBuilder:
                                                                (ctx, index) {
                                                              return Container(
                                                                width: 414.w,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 12
                                                                            .w,
                                                                        right: 12
                                                                            .w,
                                                                        top:
                                                                            8.h,
                                                                        bottom:
                                                                            8),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              child: Text('x ${order.value.food![index].pivot!.quantity}'),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.w,
                                                                            ),
                                                                            Container(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    '${order.value.food![index].name}',
                                                                                    style: TextStyle(fontSize: 18.sp),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            NumberFormat.currency(locale: 'vi').format(order.value.food![index].pivot!.price),
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20.w),
                                                                      width:
                                                                          414.w,
                                                                      child: ListView.builder(
                                                                          shrinkWrap: true,
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          itemCount: order.value.food![index].toppings!.length,
                                                                          itemBuilder: (c, i) {
                                                                            return Text(order.value.food![index].toppings![i].name!);
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child:
                                                            const Text('Hủy'),
                                                      ),
                                                    ]);
                                              });
                                        },
                                        child: Container(
                                          height: 38.h,
                                          width: 80.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              'Chi tiết',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Stepper(
                                  physics: ClampingScrollPhysics(),
                                  steps: [
                                    order.value.orderStatusId == 1
                                        ? Step(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Đặt hàng"),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 30.w),
                                                    child: Text(DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime.parse(
                                                                order.value
                                                                    .updatedAt!)
                                                            .toLocal()))),
                                              ],
                                            ),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                            isActive: true,
                                          )
                                        : Step(
                                            title: Text("Đặt hàng"),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                          ),
                                    order.value.orderStatusId == 2
                                        ? Step(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Nhận đơn"),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 30.w),
                                                    child: Text(DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime.parse(
                                                            order.value
                                                                .updatedAt!)
                                                          ..toLocal()))),
                                              ],
                                            ),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                            isActive: true,
                                          )
                                        : Step(
                                            title: Text("Nhận đơn"),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                          ),
                                    order.value.orderStatusId == 3
                                        ? Step(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Đang giao hàng"),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 30.w),
                                                    child: Text(DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime.parse(
                                                                order.value
                                                                    .updatedAt!)
                                                            .toLocal()))),
                                              ],
                                            ),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                            isActive: true,
                                          )
                                        : Step(
                                            title: Text("Đang giao hàng"),
                                            content: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                          ),
                                  ],
                                  currentStep: _index,
                                  onStepTapped: (index) {
                                    setState(() {
                                      _index = index;
                                    });
                                  },
                                  controlsBuilder: (BuildContext context,
                                          {VoidCallback? onStepContinue,
                                          VoidCallback? onStepCancel}) =>
                                      Container(),
                                ),
                                order.value.orderStatusId == 1
                                    ? GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: Text(
                                                        'Từ chối đơn hàng'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ItemField(
                                                            controller: reason,
                                                            hintText:
                                                                "Lý do từ chối",
                                                            type: TextInputType
                                                                .text,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child:
                                                            const Text('Hủy'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          var code =
                                                              await cancelOrder(
                                                                  order.value
                                                                      .id!);
                                                          if (code == 200) {
                                                            await notification(
                                                                order
                                                                    .value
                                                                    .food![0]
                                                                    .restaurant!
                                                                    .user!
                                                                    .uid!,
                                                                'Đơn hàng',
                                                                'Quán ăn có một đơn hàng bị hủy từ ${order.value.user!.username}',
                                                                4);
                                                            // if (isNotify ==
                                                            //     true) {
                                                            //   await saveNotification(
                                                            //       'Đơn hàng',
                                                            //       'Quán ăn có một đơn hàng bị hủy từ ${order.value.user!.username}',
                                                            //       '${order.value.food![0].restaurant!.user!.id}',
                                                            //       1);
                                                            // }
                                                            // var isNotifyPerson =
                                                            await notification(
                                                                order.value
                                                                    .user!.uid!,
                                                                'Đơn hàng',
                                                                'Bạn đã hủy đơn hàng từ quán ăn ${order.value.food![0].restaurant!.name}',
                                                                4);
                                                            // if (isNotifyPerson ==
                                                            //     true) {
                                                            //   await saveNotification(
                                                            //       'Đơn hàng',
                                                            //       'Bạn đã hủy đơn hàng từ quán ăn ${order.value.food![0].restaurant!.name}',
                                                            //       '${order.value.user!.id}',
                                                            //       1);
                                                            // }
                                                            Get.back();
                                                            setState(() {
                                                              fetchOrder();
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Hủy đơn hàng',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ]);
                                              });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 15.h,
                                              bottom: 10.h,
                                              left: 8.w,
                                              right: 8.w),
                                          height: 45.h,
                                          width: 360.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFF60404))),
                                          child: Center(
                                            child: Text(
                                              'Hủy Đơn Hàng',
                                              style: TextStyle(
                                                  color: Color(0xFFF60404),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
            }
          }
        });
  }

  Future<bool?> fetchOrder() async {
    var o = await getOrder();
    if (o != null) {
      print(o);
      order = o.obs;
      order.refresh();
    } else {
      order = new Order().obs;
    }
    return order.isBlank;
  }

  Future<Order?> getOrder() async {
    Order order;
    String token = (await getToken())!;
    print(token);
    try {
      print(Apis.getOrderComingUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getOrderComingUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['order']);

        order = OrderJson.fromJson(parsedJson).order!;

        return order;
      }
      if (response.statusCode == 204) {
        order = new Order();
        return order;
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }

  Future<int?> cancelOrder(int id) async {
    String token = (await getToken())!;
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.cancelOrderUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'orderId': id,
          'reason': reason.text,
        }),
      );

      print(response.statusCode);
      return response.statusCode;
      // if (response.statusCode == 200) {
      //   var parsedJson = jsonDecode(response.body);
      //   Order order = Order.fromJson(parsedJson['order']);
      //   return order;
      // }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}
