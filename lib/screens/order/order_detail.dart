import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/screens/address/address_screen.dart';
import 'package:fooddelivery/screens/order/components/delivery_item.dart';
import 'package:fooddelivery/screens/order/components/food_item.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:fooddelivery/screens/restaurant/delivery.dart';
import 'package:fooddelivery/screens/restaurant/payment.dart';
import 'package:fooddelivery/screens/restaurant/voucher.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 780.h,
                  width: 414.w,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 8, color: kPrimaryColorBackground))),
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
                              child: DeliveryItem(
                                iconData_4: Icons.edit,
                                page: AddressScreen(),
                                deliveryModel: DeliveryModel(
                                    iconData: Icons.location_on,
                                    name: users.username,
                                    address: users.listAddress![1].address),
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
                                    color: kPrimaryColorBackground, width: 8))),
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
                            Column(
                              children: [
                                FoodItem(
                                  map: order_1.listFood,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(Delivery());
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
                                'Giao hàng',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Vui lòng chọn',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.black38),
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
                          Get.to(Voucher());
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
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    // width: 150.w,
                                    height: 30.h,
                                    padding: EdgeInsets.only(
                                        left: 16.sp, right: 16.sp),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    ),

                                    child: Text(
                                      'Chọn voucher',
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
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(Payment());
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
                                    'Tiền mặt',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.black38),
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
                        onTap: () {},
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
                                    'Chưa có',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.black38),
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
                                    width: 2, color: kPrimaryColorBackground))),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              '1000đ',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: kPrimaryColorBackground))),
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
                              '1000đ',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: kPrimaryColorBackground))),
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
                              '1000đ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 116.h,
            width: 414.w,
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      '50000đ',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  height: 66.h,
                  width: 414.w,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      print('Đặt hàng');
                    },
                    child: Container(
                      height: 45.h,
                      margin: EdgeInsets.only(
                        top: 20.h,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          'Đặt hàng',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                      ),
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
