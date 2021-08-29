import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../apis.dart';
import '../../utils.dart';
import 'history_delivery_screen.dart';

class ReceivedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceivedScreen();
  }
}

class _ReceivedScreen extends State<ReceivedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Giao hàng'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
              future: fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                  if (snapshot.hasError) {
                    return EmptyScreen(text: 'Không có đơn hàng nào!');
                  } else if (snapshot.hasData) {
                    return ListView(
                      children: [
                        DeliveryMap(
                          height: 240,
                          restaurant: order.foodOrder![0].food!.restaurant!,
                          order: order,
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
                                            width: 1, color: Colors.black12))),
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
                                      'Đang đến trong 20 phút',
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
                                            width: 1, color: Colors.black12))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 384.w,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Quán ăn: ' +
                                                        order
                                                            .foodOrder![0]
                                                            .food!
                                                            .restaurant!
                                                            .name!,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.call,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              width: 414.w,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Địa chỉ quán: ',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                      ),
                                                      Container(
                                                        width: 346.w,
                                                        child: Text(
                                                          order
                                                              .foodOrder![0]
                                                              .food!
                                                              .restaurant!
                                                              .name!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 346.w,
                                                        child: Text(
                                                          order
                                                              .foodOrder![0]
                                                              .food!
                                                              .restaurant!
                                                              .phone!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 346.w,
                                                        child: Text(
                                                          order
                                                              .foodOrder![0]
                                                              .food!
                                                              .restaurant!
                                                              .address!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: FractionalOffset.topCenter,
                                margin: new EdgeInsets.only(top: 1.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 10.h,
                                      ),
                                      height: 70.h,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              //img user
                                              Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                  //image
                                                  child: Container(
                                                      width: 50.w,
                                                      height: 50.h,
                                                      child: order.user!
                                                                  .avatar ==
                                                              null
                                                          ? Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.w,
                                                                      bottom:
                                                                          10.h,
                                                                      left:
                                                                          10.w,
                                                                      top:
                                                                          10.h),
                                                              child: ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/user.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          50)),
                                                              child:
                                                                  Image.network(
                                                                Apis.baseURL +
                                                                    order.user!
                                                                        .avatar!,
                                                                width: 100.w,
                                                                height: 100.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )))),
                                              //user name
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child:
                                                    Text(order.user!.username!),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.call,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.message,
                                                        size: 20,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //địa chỉ người mua
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                        top: 2.h,
                                        left: 10.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Địa chỉ nhận hàng: ',
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              ),
                                              Container(
                                                width: 346.w,
                                                child: Text(
                                                  order.user!.username!,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                width: 346.w,
                                                child: Text(
                                                  order.user!.phone!,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                width: 346.w,
                                                child: Text(
                                                  order.addressDelivery!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors
                                                        .grey.shade300)))),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 1.w,
                                          top: 10.h),
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 8.w,
                                                top: 8.h,
                                                bottom: 8.w),
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        order.foodOrder!.length,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 24.w,
                                                            child: Text(order
                                                                    .foodOrder![
                                                                        ind]
                                                                    .quantity
                                                                    .toString() +
                                                                ' x'),
                                                          ),
                                                          Container(
                                                            width: 230.w,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  order
                                                                      .foodOrder![
                                                                          ind]
                                                                      .food!
                                                                      .name!,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18.sp),
                                                                ),
                                                                Container(
                                                                  width: 230.w,
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: order
                                                                              .foodOrder![
                                                                                  ind]
                                                                              .toppings!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, i) {
                                                                            return Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "+ " + '${order.foodOrder![ind].toppings![i].name!}: ' + ' ${NumberFormat.currency(locale: 'vi').format(order.foodOrder![ind].toppings![i].price!)}',
                                                                                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 1.h,
                                                                                )
                                                                              ],
                                                                            );
                                                                          }),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 100.w,
                                                            child: Text(
                                                              NumberFormat.currency(
                                                                      locale:
                                                                          'vi')
                                                                  .format(order
                                                                      .foodOrder![
                                                                          ind]
                                                                      .price),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      EdgeInsets.all(10.sp),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.sp)),
                                                    color: Colors.grey[100],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'Ghi chú của khách hàng:',
                                                          style: TextStyle(
                                                              fontSize: 16.sp),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          order.note == null
                                                              ? "Chưa có"
                                                              : order.note!,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 7.w),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    'PTTT: ' +
                                                        order.payment!.method! +
                                                        '_' +
                                                        order.payment!.status!,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 7.w),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      'Phí giao hàng: ' +
                                                          NumberFormat.currency(
                                                                  locale: 'vi')
                                                              .format(order
                                                                  .priceDelivery),
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 7.w),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    'Tổng: ' +
                                                        NumberFormat.currency(
                                                                locale: 'vi')
                                                            .format(
                                                                order.price),
                                                    style: TextStyle(
                                                        fontSize: 20.sp),
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
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text('Xác nhận đơn hàng'),
                                            content: SingleChildScrollView(
                                                child: Text(
                                                    'Xác nhận đơn hàng đã giao thành công.')),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: const Text(
                                                  'Hủy',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  print(order.id);
                                                  await changeDelivery(
                                                      order.id);
                                                  Get.back();
                                                  bool isNotify =
                                                      await notification(
                                                          order
                                                              .foodOrder![0]
                                                              .food!
                                                              .restaurant!
                                                              .user!
                                                              .uid!,
                                                          'Giao hàng',
                                                          'Đơn hàng #${order.id} đã giao thành công bởi ${order.userDelivery!.username}');
                                                  if (isNotify == true) {
                                                    await saveNotification(
                                                        'Giao hàng',
                                                        'Đơn hàng #${order.id} đã giao thành công bởi ${order.userDelivery!.username}',
                                                        '${order.foodOrder![0].food!.restaurant!.user!.id}',
                                                        3);
                                                  }
                                                  await Get.off(
                                                      () =>
                                                          HistoryDeliveryScreen(),
                                                      arguments: {
                                                        'userId': userId
                                                      });
                                                  // Get.back();
                                                },
                                                child: const Text(
                                                  'Xác nhận',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ]);
                                      });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 360.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          width: 1, color: Colors.blue)),
                                  child: Center(
                                    child: Text(
                                      'Xác nhận đã giao',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return EmptyScreen(text: 'Không có đơn hàng nào!');
                  }
                }
              }),
        ),
      ),
    );
  }

  late Order order;
  late int userId;
  late bool isDelivery = false;

  @override
  void initState() {
    order = new Order();
    userId = Get.arguments['userId'];
    print(userId);
    // fetch();
    super.initState();
  }

  Future<bool?> fetch() async {
    var o = await isDeliverys();
    print(' vao ddaay ce $o');
    if (o != null) {
      order = o;
    }
    return o.isBlank;
  }

  Future<Order?> isDeliverys() async {
    Order? order;
    String? token = (await getToken());
    Map<String, String> queryParams = {
      'userId': userId.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;
    try {
      print(Apis.isDeliveryUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.isDeliveryUrl + '?' + queryString),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['odrer']);
        order = OrderJson.fromJson(parsedJson).order;
        // print(users);
        return order;
      }
      if (response.statusCode == 401) {}
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
    return null;
  }

  Future<void> changeDelivery(int? id) async {
    String? token = await getToken();
    print(token);
    print(id);
    print(userId);
    try {
      // EasyLoading.show(status: 'Loading...');
      print(Apis.changeDeliveryUrl);
      http.Response response = await http.post(
        Uri.parse(Apis.changeDeliveryUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'orderId': id,
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // EasyLoading.dismiss();
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['order']);
        // Order order = Order.fromJson(parsedJson);
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
  }
}
