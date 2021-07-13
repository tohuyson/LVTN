import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/order_controller.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/screens/order/components/card_item.dart';
import 'package:fooddelivery/screens/order/order_coming.dart';
import 'package:fooddelivery/screens/order/order_item.dart';
import 'package:get/get.dart';

class OrderScreen extends GetView<OrderController> {
  OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Đơn hàng',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: kPrimaryColorBackground,
          width: double.infinity,
          height: 834.h,
          child: Column(
            children: [
              Container(
                height: 50.h,
                color: Colors.white,
                padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                child: TabBar(
                  labelColor: Colors.black,
                  controller: controller.tabController,
                  tabs: controller.myTabs,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Text('dasd'),
                    Text('dasdhsk'),
                    // order_1.status == false
                    //     ? OrderComing(
                    //         order: order_1,
                    //       )
                    //     : Text('Không có đơn hàng'),
                    // listOrder.isNotEmpty
                    //     ? OrderItem(
                    //         listOrder: listOrder,
                    //       )
                    //     : Text('Không có đơn hàng'),
                    Column(
                      children: [
                        CardItem(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
