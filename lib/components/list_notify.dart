import 'package:flutter/material.dart';
import 'package:fooddelivery/components/notify_item.dart';

class ListNotify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      height: MediaQuery.of(context).size.height/1.287,
      child: ListView(
        children: [
          NotifyItem(title: 'Giao hàng', content: 'Giao đơn hàng thành công',),
          NotifyItem(title: 'Giao hàng', content: 'Giao đơn hàng thành công',),
          NotifyItem(title: 'Giao hàng', content: 'Giao đơn hàng thành công',),
          NotifyItem(title: 'Giao hàng', content: 'Giao đơn hàng thành công',),
          NotifyItem(title: 'Giao hàng', content: 'Giao đơn hàng thành công',),
        ],
      ),
    );
  }

}