import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_item.dart';
import 'package:fooddelivery/screens/order/components/food_item.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailDelivered extends StatefulWidget {
  final Order? order;

  OrderDetailDelivered({this.order});

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailDelivered(order: order);
  }
}

class _OrderDetailDelivered extends State<OrderDetailDelivered> {
  final Order? order;
  String note = 'Chưa có';
  final myController = TextEditingController();

  _OrderDetailDelivered({this.order});

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void changedtext() {
    setState(() {
      print(note);
      note != 'Chưa có' ? myController.text = note : myController.text;
    });
  }

  showPicker() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
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
        title: Text('Chi tiết đơn hàng'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: kPrimaryColorBackground,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.only(
                      left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
                  child: Text('Giao hàng'),
                ),
                Container(
                  height: 80.h,
                  padding: EdgeInsets.only(
                    left: 12.w,
                    right: 12.w,
                    top: 4.h,
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: DeliveryItem(
                    deliveryModel: DeliveryModel(
                      iconData: Icons.restaurant_menu,
                      name: order!.restaurant!.name,
                      address: order!.restaurant!.address,
                    ),
                    iconData_1: Icons.my_location,
                    iconData_2: Icons.call,
                    iconData_3: Icons.message,
                  ),
                ),
                Container(
                  height: 80.h,
                  padding: EdgeInsets.only(
                    left: 12.w,
                    right: 12.w,
                    top: 4.h,
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: DeliveryItem(
                    deliveryModel: DeliveryModel(
                      iconData: Icons.home,
                      name: order!.user!.username,
                      address: order!.user!.listAddress![1].address,
                    ),
                    iconData_1: Icons.my_location,
                    iconData_2: Icons.call,
                    iconData_3: Icons.message,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: kPrimaryColorBackground, width: 1))),
                        padding: EdgeInsets.only(
                            left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
                        child: Text(
                          'Chi tiết đơn hàng',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      Column(
                        children: [
                          FoodItem(
                            map: order!.listFood,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 4.h,
                          bottom: 8.h,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: kPrimaryColorBackground, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng (1 phần)',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              '30000đ',
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8.0.h, top: 8.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: kPrimaryColorBackground))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phí giao hàng',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              '-15000đ',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8.0.h, top: 8.h),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: kPrimaryColorBackground))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vorcher',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              '-10000đ',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng cộng',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '10000đ',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phương thức thanh toán',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        'Tiền mặt',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showPicker();
                    changedtext();
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ghi chú',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 250.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                note,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black45),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16.sp,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
