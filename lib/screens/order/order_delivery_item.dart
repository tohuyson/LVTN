import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/components/delivery_item.dart';
import 'package:fooddelivery/screens/order/delivery_screen.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:fooddelivery/screens/order/order_detail_delivered.dart';
import 'package:get/get.dart';

class OrderDeliveryItem extends StatelessWidget {
  final Order? order;

  OrderDeliveryItem({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 248.h,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.h, bottom: 6.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 6, color: kPrimaryColorBackground))),
      child: Column(
        children: [
          Container(
            height: 35.h,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: kPrimaryColorBackground, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ' + order!.id.toString(),
                  style: TextStyle(fontSize: 15.sp),
                ),
                InkWell(
                    onTap: () async {
                      await Get.to(() => OrderDetailDelivered(
                            order: order,
                          ));
                    },
                    child: Text(
                      'Chi tiết',
                      style: TextStyle(fontSize: 15.sp),
                    )),
              ],
            ),
          ),
          DeliveryItem(
            deliveryModel: DeliveryModel(
              iconData: Icons.restaurant_menu,
              name: order!.restaurant!.name,
              address: order!.restaurant!.address,
            ),
          ),
          DeliveryItem(
            deliveryModel: DeliveryModel(
              iconData: Icons.home,
              name: order!.user!.username,
              address: order!.user!.listAddress![1].address,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.access_alarm),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('10:30'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.send),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1.5km'),
                  )
                ],
              ),
              SizedBox(
                width: 46.w,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 35.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                        color: kPrimaryColorBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'Từ chối',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(DeliveryScreen(
                      order: order,
                    ));
                  },
                  child: Container(
                    height: 35.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'Nhận đơn',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
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
