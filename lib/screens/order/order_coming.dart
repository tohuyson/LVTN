import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_map.dart';

class OrderComing extends StatefulWidget {
  final Order order;

  OrderComing({this.order});

  @override
  State<StatefulWidget> createState() => _OrderDetail(order: order);
}

class _OrderDetail extends State<OrderComing> {
  final Order order;

  _OrderDetail({this.order});

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DeliveryMap(height: 240,),
        Container(
          height: 450.h,
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
                padding: EdgeInsets.only(bottom: 6.h, left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(
                          order.category,
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
                margin: EdgeInsets.only(top: 6.h, left: 10.w, right: 10.w),
                padding: EdgeInsets.only(bottom: 6.h, left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),

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
                            order.listFood.values.elementAt(0).name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          AutoSizeText(
                            'Tổng: ' +
                                order.price.toString() +
                                ' - ' +
                                order.method,
                            style: TextStyle(fontSize: 14),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 38.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
                steps: [
                  Step(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
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
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1, color: Color(0xFFF60404))),
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
    );
  }
}
