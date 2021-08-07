import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/chat/widget/loading.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../apis.dart';
import 'package:intl/intl.dart';

import '../../utils.dart';

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
                // return buildLoading();
                return order!.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: order!.length,
                        itemBuilder: (context, index) {
                          return OrderHistoryCard(
                            item: order![index],
                          );
                        },
                      )
                    : EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
              }
            }
          }),
    );
  }

  Future<void> fetch() async {
    var list = await getHistory();
    if (list != null) {
      // printInfo(info: listFood.length.toString());
      // print(listFood.length);
      order!.assignAll(list);
      order!.refresh();
      // print(food.length);
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
        // print(parsedJson['food']);
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
                      Text(
                        item!.food![0].restaurant!.name!,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
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

        ],
      ),
    );
  }
}
