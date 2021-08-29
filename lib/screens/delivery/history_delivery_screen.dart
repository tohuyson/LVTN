import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/widget/empty_screen.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../apis.dart';
import 'package:intl/intl.dart';

import '../../utils.dart';

class HistoryDeliveryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryDeliveryScreen();
  }
}

class _HistoryDeliveryScreen extends State<HistoryDeliveryScreen> {
  RxList<Order>? order;
  late int userId;

  @override
  void initState() {
    order = new RxList<Order>();
    userId = Get.arguments['userId'];
    print(userId);
    // fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lịch sử giao hàng'),
      ),
      body: Container(
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
      ),
    );
  }

  Future<void> fetch() async {
    var list = await historyDelivery();
    if (list != null) {
      // printInfo(info: listFood.length.toString());
      print(list.length);
      order!.assignAll(list);
      order!.refresh();
      // print(food.length);
    }
  }

  Future<List<Order>?> historyDelivery() async {
    List<Order> list;
    String? token = (await getToken());
    Map<String, String> queryParams = {
      'userId': userId.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;
    try {
      print(Apis.historyDeliveryUrl);
      http.Response response = await http.get(
        Uri.parse(Apis.historyDeliveryUrl + '?' + queryString),
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
      alignment: FractionalOffset.topCenter,
      margin: new EdgeInsets.only(top: 1.h),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [Text(formatter.format(listOrder[index].updatedAt.)),
                // children: [Text(new DateFormat('yyyy-MM-dd').parse(listOrder[index].updatedAt).toString()),
                children: [
                  Text(DateFormat('yyyy-MM-dd HH:mm').format(
                      DateTime.parse(
                          item!.updatedAt!))),
                  item!.orderStatusId == 5
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
                            color: Colors.grey.shade300)))),
            Container(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.food_bank,
                        color: Colors.blue,
                        size: 30.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('Quán ăn'),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                insetPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                                contentPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                                title: Text('Thông tin người giao hàng'),
                                content: SingleChildScrollView(
                                  child: Container(
                                    width: 344.w,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 344.w,
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: Text(
                                              'Quán ăn: ' +
                                                  item!.foodOrder![0].food!.restaurant!.name!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            width: 344.w,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
                                                  width: 308.w,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 308.w,
                                                        child: Text(
                                                          'Địa chỉ quán: ',
                                                          style: TextStyle(fontSize: 16.sp),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 308.w,
                                                        child: Text(
                                                          item!.foodOrder![0].food!.restaurant!.name!,
                                                          style: TextStyle(color: Colors.grey),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 308.w,
                                                        child: Text(
                                                          item!.foodOrder![0].food!.restaurant!.phone!,
                                                          style: TextStyle(color: Colors.grey),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Container(
                                                        width: 308.w,
                                                        child: Text(
                                                          item!.foodOrder![0].food!.restaurant!.address!,
                                                          softWrap: true,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Ok'),
                                  ),
                                ]);
                          });
                    },
                  )
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: Colors.grey.shade300)))),
            Container(
              padding: EdgeInsets.only(
                top: 5.h,
                left: 10.h,
              ),
              height: 50.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //img user
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black12),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          //image
                          child: Container(
                              width: 50.w,
                              height: 50.h,
                              child: item!.user!.avatar == null
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          right: 10.w,
                                          bottom: 10.h,
                                          left: 10.w,
                                          top: 10.h),
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'assets/images/user.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      child: Image.network(
                                        Apis.baseURL + item!.user!.avatar!,
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                      )))),
                      //user name
                      Container(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(item!.user!.username!),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                insetPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                                contentPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                                title: Text('Thông tin người giao hàng'),
                                content: SingleChildScrollView(
                                  child:Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    width: 344.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Container(
                                          width: 308.w,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 308.w,
                                                child: Text(
                                                  'Địa chỉ nhận hàng: ',
                                                  style: TextStyle(fontSize: 16.sp),
                                                ),
                                              ),
                                              Container(
                                                width: 308.w,
                                                child: Text(
                                                  item!.user!.username!,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                width: 308.w,
                                                child: Text(
                                                  item!.user!.phone!,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                width: 308.w,
                                                child: Text(
                                                  item!.addressDelivery!,
                                                  overflow: TextOverflow.clip,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Ok'),
                                  ),
                                ]);
                          });
                    },
                  )
                ],
              ),
            ),
            //địa chỉ người mua

            SizedBox(
              height: 10.h,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: Colors.grey.shade300)))),
            Container(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, bottom: 1.w, top: 10.h),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8.w, top: 8.h, bottom: 8.w),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: item!.foodOrder!.length,
                            itemBuilder: (context, ind) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24.w,
                                    child: Text(item!.foodOrder![ind].quantity
                                            .toString() +
                                        ' x'),
                                  ),
                                  Container(
                                    width: 230.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item!.foodOrder![ind].food!.name!,
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 230.w,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: item!.foodOrder![ind]
                                                  .toppings!.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "+ " +
                                                          '${item!.foodOrder![ind].toppings![i].name!}: ' +
                                                          ' ${NumberFormat.currency(locale: 'vi').format(item!.foodOrder![ind].toppings![i].price!)}',
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: Colors.grey),
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
                                      NumberFormat.currency(locale: 'vi')
                                          .format(item!.foodOrder![ind].price),
                                      textAlign: TextAlign.right,
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
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.sp)),
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Ghi chú của khách hàng:',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  item!.note == null ? "Chưa có" : item!.note!,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 7.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'PTTT: ' +
                                item!.payment!.method! +
                                '_' +
                                item!.payment!.status!,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 7.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                              'Phí giao hàng: ' +
                                  NumberFormat.currency(locale: 'vi')
                                      .format(item!.priceDelivery),
                              style: TextStyle(color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 7.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Tổng: ' +
                                NumberFormat.currency(locale: 'vi')
                                    .format(item!.price),
                            style: TextStyle(fontSize: 20.sp),
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
    );
    //   Container(
    //   padding: EdgeInsets.only(
    //     top: 3.h,
    //     left: 8.h,
    //   ),
    //   margin: EdgeInsets.only(top: 10.h, left: 12.h, right: 10.w),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(8.sp)),
    //     color: Colors.white,
    //   ),
    //   // height: 100.h,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         padding: EdgeInsets.only(left: 15.w, right: 15.w),
    //         height: 50.h,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(DateFormat('yyyy-MM-dd HH:mm')
    //                 .format(DateTime.parse(item!.updatedAt!))),
    //             item!.orderStatusId == 5 ? Text('Đã hủy') : Text('Đã giao')
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
    //         child: Row(
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 border: Border.all(width: 1, color: Colors.black12),
    //                 borderRadius: BorderRadius.all(Radius.circular(5)),
    //               ),
    //               child: item!.food![0].restaurant == null
    //                   ? Container(
    //                 width: 80.w,
    //                 height: 80.w,
    //                 padding: EdgeInsets.only(
    //                     right: 12.w, bottom: 12.h, left: 12.w, top: 12.h),
    //                 child: Image.asset(
    //                   'assets/images/user.png',
    //                   fit: BoxFit.fill,
    //                   color: Colors.black26,
    //                 ),
    //               )
    //                   : Container(
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.all(Radius.circular(5)),
    //                   child: Image.network(
    //                     Apis.baseURL + item!.food![0].restaurant!.image!,
    //                     width: 72.w,
    //                     height: 80.h,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               padding: EdgeInsets.only(left: 15.w, right: 10.w),
    //               height: 92.h,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Text(
    //                     item!.food![0].restaurant!.name!,
    //                     style: TextStyle(
    //                         fontSize: 20.sp, fontWeight: FontWeight.w600),
    //                   ),
    //                   Text('Địa chỉ : ' +
    //                       item!.food![0].restaurant!.address.toString()),
    //                   Text('Giá : ' + item!.price.toString() + ' đ'),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //
    //     ],
    //   ),
    // );
  }
}
