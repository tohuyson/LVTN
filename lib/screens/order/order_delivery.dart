import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/order_delivery_item.dart';

class OrderDelivery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Đơn hàng'),
      ),
      body: Container(
        width: double.infinity,
        height: 834.h,
        child: ListView(
          children: [
            for (Order o in listOrder)
              OrderDeliveryItem(
                order: o,
              ),
          ],
        ),
      ),
    );
  }
}
