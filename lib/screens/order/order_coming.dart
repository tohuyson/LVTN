import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_map.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../apis.dart';
import '../../utils.dart';
import '../widget/empty_screen.dart';

class OrderComing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderDetail();
}

class _OrderDetail extends State<OrderComing> {
  // Order? o;
  int _index = 0;
  bool isLoading = false;
  late Rx<Order> order;

  @override
  void initState() {
    order = new Rx(new Order());
    fetchOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     DeliveryMap(
    //       height: 240,
    //     ),
    //     Container(
    //       // height: 450.h,
    //       width: double.infinity,
    //       color: Colors.white,
    //       child: Column(
    //         children: [
    //           Container(
    //             margin: EdgeInsets.only(
    //               left: 10.w,
    //               right: 10.w,
    //               top: 6.h,
    //             ),
    //             padding: EdgeInsets.only(bottom: 6.h, left: 5.w, right: 5.w),
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border(
    //                     bottom: BorderSide(width: 1, color: Colors.black12))),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                     child: Text(
    //                   'Đồ ăn',
    //                   style: TextStyle(fontSize: 16.sp),
    //                 )),
    //                 Container(
    //                     child: Text(
    //                   'Đang đến trong 20 phút',
    //                   style: TextStyle(fontSize: 16.sp),
    //                 )),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(top: 6.h, left: 10.w, right: 10.w),
    //             padding: EdgeInsets.only(bottom: 6.h, left: 5.w, right: 5.w),
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border(
    //                     bottom: BorderSide(width: 1, color: Colors.black12))),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   width: 290.w,
    //                   height: 55.h,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       AutoSizeText(
    //                         order.value.food![0].restaurant!.name!,
    //                         style: TextStyle(fontSize: 16),
    //                       ),
    //                       SizedBox(
    //                         height: 4.h,
    //                       ),
    //                       AutoSizeText(
    //                         'Tổng: ' +
    //                             order.value.price.toString() +
    //                             ' - ' +
    //                             order.value.payment!.method! +
    //                             ' - ' +
    //                             order.value.payment!.status!,
    //                         style: TextStyle(fontSize: 14),
    //                         maxLines: 1,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     showDialog(
    //                         context: context,
    //                         builder: (context) {
    //                           return AlertDialog(
    //                               title: Text('Chi tiết đơn hàng'),
    //                               content: Container(
    //                                 width: 414.w,
    //                                 child: Column(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: [
    //                                     ListView.builder(
    //                                       shrinkWrap: true,
    //                                       physics:
    //                                           NeverScrollableScrollPhysics(),
    //                                       itemCount: order.value.food!.length,
    //                                       itemBuilder: (ctx, index) {
    //                                         return Container(
    //                                           width: 414.w,
    //                                           padding: EdgeInsets.only(
    //                                               left: 8.w,
    //                                               right: 8.w,
    //                                               top: 8.h,
    //                                               bottom: 8),
    //                                           child: Column(
    //                                             children: [
    //                                               Row(
    //                                                 mainAxisAlignment:
    //                                                     MainAxisAlignment
    //                                                         .spaceBetween,
    //                                                 crossAxisAlignment:
    //                                                     CrossAxisAlignment
    //                                                         .start,
    //                                                 children: [
    //                                                   Row(
    //                                                     children: [
    //                                                       Container(
    //                                                         child: Text(
    //                                                             'x ${order.value.food![index].pivot!.quantity}'),
    //                                                       ),
    //                                                       Container(
    //                                                         child: Column(
    //                                                           crossAxisAlignment:
    //                                                               CrossAxisAlignment
    //                                                                   .start,
    //                                                           children: [
    //                                                             Text(
    //                                                               '${order.value.food![index].name}',
    //                                                               style: TextStyle(
    //                                                                   fontSize:
    //                                                                       18.sp),
    //                                                             ),
    //                                                           ],
    //                                                         ),
    //                                                       ),
    //                                                     ],
    //                                                   ),
    //                                                   Container(
    //                                                     child: Text(
    //                                                       '${order.value.food![index].pivot!.price}',
    //                                                       textAlign:
    //                                                           TextAlign.right,
    //                                                     ),
    //                                                   ),
    //                                                 ],
    //                                               ),
    //                                               Container(
    //                                                 padding: EdgeInsets.only(
    //                                                     left: 20.w),
    //                                                 width: 414.w,
    //                                                 child: ListView.builder(
    //                                                     shrinkWrap: true,
    //                                                     physics:
    //                                                         NeverScrollableScrollPhysics(),
    //                                                     itemCount: order.value
    //                                                         .food![index]
    //                                                         .toppings!
    //                                                         .length,
    //                                                     itemBuilder: (c, i) {
    //                                                       return Text(order.value
    //                                                           .food![index]
    //                                                           .toppings![i]
    //                                                           .name!);
    //                                                     }),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         );
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                               actions: <Widget>[
    //                                 TextButton(
    //                                   onPressed: () => Get.back(),
    //                                   child: const Text('Hủy'),
    //                                 ),
    //                               ]);
    //                         });
    //                   },
    //                   child: Container(
    //                     height: 38.h,
    //                     width: 80.w,
    //                     decoration: BoxDecoration(
    //                         color: Theme.of(context).primaryColor,
    //                         borderRadius: BorderRadius.all(Radius.circular(5))),
    //                     child: Center(
    //                       child: Text(
    //                         'Chi tiết',
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.w400),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Stepper(
    //             physics: ClampingScrollPhysics(),
    //             steps: [
    //               Step(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("Đặt đơn"),
    //                     Container(
    //                         padding: EdgeInsets.only(right: 30.w),
    //                         child: Text("10:30")),
    //                   ],
    //                 ),
    //                 content: SizedBox(
    //                   width: 0,
    //                   height: 0,
    //                 ),
    //                 isActive: true,
    //               ),
    //               Step(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("Xác nhận đơn hàng"),
    //                     Container(
    //                         padding: EdgeInsets.only(right: 30.w),
    //                         child: Text("10:30")),
    //                   ],
    //                 ),
    //                 content: SizedBox(
    //                   width: 0,
    //                   height: 0,
    //                 ),
    //               ),
    //               Step(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("Giao hàng"),
    //                     Container(
    //                         padding: EdgeInsets.only(right: 30.w),
    //                         child: Text("10:30")),
    //                   ],
    //                 ),
    //                 content: SizedBox(
    //                   width: 0,
    //                   height: 0,
    //                 ),
    //               ),
    //               Step(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("Đã giao hàng"),
    //                     Container(
    //                         padding: EdgeInsets.only(right: 30.w),
    //                         child: Text("10:30")),
    //                   ],
    //                 ),
    //                 content: SizedBox(
    //                   width: 0,
    //                   height: 0,
    //                 ),
    //               ),
    //               Step(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("Hoàn thành"),
    //                     Container(
    //                         padding: EdgeInsets.only(right: 30.w),
    //                         child: Text("10:30")),
    //                   ],
    //                 ),
    //                 content: SizedBox(
    //                   width: 0,
    //                   height: 0,
    //                 ),
    //               ),
    //             ],
    //             currentStep: _index,
    //             onStepTapped: (index) {
    //               setState(() {
    //                 _index = index;
    //               });
    //             },
    //             controlsBuilder: (BuildContext context,
    //                     {VoidCallback? onStepContinue,
    //                     VoidCallback? onStepCancel}) =>
    //                 Container(),
    //           ),
    //           InkWell(
    //             onTap: () {},
    //             child: Container(
    //               margin: EdgeInsets.only(
    //                   top: 15.h, bottom: 10.h, left: 8.w, right: 8.w),
    //               height: 45.h,
    //               width: 360.w,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.all(Radius.circular(5)),
    //                   border: Border.all(width: 1, color: Color(0xFFF60404))),
    //               child: Center(
    //                 child: Text(
    //                   'Hủy Đơn Hàng',
    //                   style: TextStyle(
    //                       color: Color(0xFFF60404),
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return FutureBuilder(
        future: getOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            if (snapshot.hasError) {
              return EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
            } else {
              // return buildLoading();
              return order.value.id!= null? ListView(
                children: [
                  DeliveryMap(
                    height: 240,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 290.w,
                                height: 55.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      order.value.food![0].restaurant!.name!,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    AutoSizeText(
                                      'Tổng: ' +
                                          order.value.price.toString() +
                                          ' - ' +
                                          order.value.payment!.method! +
                                          ' - ' +
                                          order.value.payment!.status!,
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text('Chi tiết đơn hàng'),
                                            content: Container(
                                              width: 414.w,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: order
                                                        .value.food!.length,
                                                    itemBuilder: (ctx, index) {
                                                      return Container(
                                                        width: 414.w,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.w,
                                                                right: 8.w,
                                                                top: 8.h,
                                                                bottom: 8),
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
                                                                      child: Text(
                                                                          'x ${order.value.food![index].pivot!.quantity}'),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${order.value.food![index].name}',
                                                                            style:
                                                                                TextStyle(fontSize: 18.sp),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    '${order.value.food![index].pivot!.price}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          20.w),
                                                              width: 414.w,
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: order
                                                                          .value
                                                                          .food![
                                                                              index]
                                                                          .toppings!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (c, i) {
                                                                        return Text(order
                                                                            .value
                                                                            .food![index]
                                                                            .toppings![i]
                                                                            .name!);
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
                                                onPressed: () => Get.back(),
                                                child: const Text('Hủy'),
                                              ),
                                            ]);
                                      });
                                },
                                child: Container(
                                  height: 38.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
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
                            Step(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Đặt đơn"),
                                  Container(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: Text("10:30")),
                                ],
                              ),
                              content: SizedBox(
                                width: 0,
                                height: 0,
                              ),
                              isActive: true,
                            ),
                            Step(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Xác nhận đơn hàng"),
                                  Container(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: Text("10:30")),
                                ],
                              ),
                              content: SizedBox(
                                width: 0,
                                height: 0,
                              ),
                            ),
                            Step(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Giao hàng"),
                                  Container(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: Text("10:30")),
                                ],
                              ),
                              content: SizedBox(
                                width: 0,
                                height: 0,
                              ),
                            ),
                            Step(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Đã giao hàng"),
                                  Container(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: Text("10:30")),
                                ],
                              ),
                              content: SizedBox(
                                width: 0,
                                height: 0,
                              ),
                            ),
                            Step(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Hoàn thành"),
                                  Container(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: Text("10:30")),
                                ],
                              ),
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
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 15.h, bottom: 10.h, left: 8.w, right: 8.w),
                            height: 45.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    width: 1, color: Color(0xFFF60404))),
                            child: Center(
                              child: Text(
                                'Hủy Đơn Hàng',
                                style: TextStyle(
                                    color: Color(0xFFF60404),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ): EmptyScreen(text: 'Bạn chưa có đơn hàng nào.');
            }
          }
        });
  }

  // Widget buildLoading() {
  //   return Positioned(
  //     child: isLoading
  //         ? const Loading()
  //         : EmptyScreen(text: "Bạn chưa có đơn hàng nào."),
  //   );
  // }

  Future<bool?> fetchOrder() async {
    var o = await getOrder();
    if (o!.id != null) {
      print(o);
      order = o.obs;
      order.refresh();
    }else{
      order = new Order().obs;
    }
    return order.isBlank;
  }

  Future<Order?> getOrder() async {
    Order order;
    String token = (await getToken())!;
    print(token);
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getOrderUrl),
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

        if (parsedJson['order'] != null) {
          order = OrderJson.fromJson(parsedJson).order!;
        } else {
          order = new Order();
        }
        return order;
      }
      if (response.statusCode == 401) {
        showToast("Tải dữ liệu thất bại");
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
}
