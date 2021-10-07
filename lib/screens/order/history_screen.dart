import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/review/review_screen.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryScreen();
  }
}

class _HistoryScreen extends State<HistoryScreen> {
  RxList<Order>? order;

  @override
  void initState() {
    order = new RxList<Order>();
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.h),
      color: Color(0xFFEEEEEE),
      height: 834.h,
      child: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              if (snapshot.hasError) {
                return EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
              } else {
                return RefreshIndicator(
                  onRefresh: fetch,
                  child: Obx(
                    () => order!.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: order!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 414.w,
                                padding: EdgeInsets.only(
                                  top: 3.h,
                                ),
                                margin: EdgeInsets.only(
                                    top: 10.h, left: 10.h, right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sp)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 12.w, right: 12.w),
                                      height: 50.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(DateFormat('yyyy-MM-dd HH:mm')
                                              .format(DateTime.parse(
                                                  order![index].updatedAt!).toLocal())),
                                          order![index].orderStatusId == 5
                                              ? Text('Đã hủy')
                                              : Text('Đã giao')
                                        ],
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors
                                                        .grey.shade300)))),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 12.h,
                                          bottom: 12.h,
                                          left: 12.w,
                                          right: 12.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black12),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: order![index]
                                                        .foodOrder![0]
                                                        .food!
                                                        .restaurant ==
                                                    null
                                                ? Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    padding: EdgeInsets.only(
                                                        right: 12.w,
                                                        bottom: 12.h,
                                                        left: 12.w,
                                                        top: 12.h),
                                                    child: Image.asset(
                                                      'assets/images/user.png',
                                                      fit: BoxFit.fill,
                                                      color: Colors.black26,
                                                    ),
                                                  )
                                                : Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      child: Image.network(
                                                        Apis.baseURL +
                                                            order![index]
                                                                .foodOrder![0]
                                                                .food!
                                                                .restaurant!
                                                                .image!,
                                                        width: 72.w,
                                                        height: 80.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            width: 290.w,
                                            padding: EdgeInsets.only(
                                                left: 12.w, right: 12.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.food_bank,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      order![index]
                                                          .foodOrder![0]
                                                          .food!
                                                          .restaurant!
                                                          .name!,
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4,),
                                                Text(
                                                  'Địa chỉ : ' +
                                                      order![index]
                                                          .foodOrder![0]
                                                          .food!
                                                          .restaurant!
                                                          .address
                                                          .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 4,),
                                                Text('Giá : ' +
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(order![index]
                                                            .price)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors
                                                        .grey.shade300)))),
                                    order![index].orderStatusId == 4 ?
                                    Center(
                                      child: Container(
                                        height: 55.h,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(ReviewScreen(), arguments: {
                                              'order': order![index]
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 190.w,
                                            child: Text(
                                              'Đánh giá',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ):Container(),
                                  ],
                                ),
                              );
                            },
                          )
                        : EmptyScreen(text: 'Bạn chưa có đơn hàng nào.'),
                  ),
                );
              }
            }
          }),
    );
  }

  Future<void> fetch() async {
    var list = await getHistory();
    if (list != null) {
      order!.assignAll(list);
      order!.refresh();
    }
  }

  Future<List<Order>?> getHistory() async {
    List<Order> list;
    String? token = (await getToken());
    try {
      print(Apis.getHistoryUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.getHistoryUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListOrders.fromJson(parsedJson).order!;
        print(list);
        return list;
      }
      if (response.statusCode == 401) {
        showToast("Loading faild");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
      print(e.toString());
    }
    return null;
  }
}

class OrderHistoryCard extends StatelessWidget {
  final Order? item;

  const OrderHistoryCard({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 3.h,
        left: 8.h,
      ),
      margin: EdgeInsets.only(top: 10.h, left: 12.h, right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        color: Colors.white,
      ),
      // height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('yyyy-MM-dd HH:mm')
                    .format(DateTime.parse(item!.updatedAt!))),
                item!.orderStatusId == 5 ? Text('Đã hủy') : Text('Đã giao')
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5, color: Colors.grey.shade300)))),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: item!.food![0].restaurant == null
                      ? Container(
                          width: 80.w,
                          height: 80.w,
                          padding: EdgeInsets.only(
                              right: 12.w, bottom: 12.h, left: 12.w, top: 12.h),
                          child: Image.asset(
                            'assets/images/user.png',
                            fit: BoxFit.fill,
                            color: Colors.black26,
                          ),
                        )
                      : Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                              Apis.baseURL + item!.food![0].restaurant!.image!,
                              width: 72.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.w, right: 10.w),
                  height: 92.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.food_bank,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            item!.food![0].restaurant!.name!,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text('Địa chỉ : ' +
                          item!.food![0].restaurant!.address.toString()),
                      Text('Giá : ' + item!.price.toString() + ' đ'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5, color: Colors.grey.shade300)))),
          Center(
            child: Container(
              height: 55.h,
              child: InkWell(
                onTap: () {
                  print('ddaay laf danh gia');
                  Get.to(ReviewScreen(), arguments: {'order': item});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 190.w,
                  child: Text(
                    'Đánh giá',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
