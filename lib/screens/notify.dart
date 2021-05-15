import 'package:flutter/material.dart';
import 'package:fooddelivery/components/list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/notify_item.dart';
import 'package:fooddelivery/components/three_button_horizontal.dart';

class Notify extends StatelessWidget {
  final int selectedIndex;
  Notify(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    List<NotifyItem> list = [
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      NotifyItem(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Thông báo',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22.sp,
                color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
                size: 28.sp,
              ),
              onPressed: () {
                print("Map");
              }),
        ],
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: Column(
          children: [
            ButtonHorizontal(
              txtbt1: 'Chưa đọc',
              txtbt2: 'Đơn hàng',
              txtbt3: 'Tất cả',
            ),
            ListWidget(list),
          ],
        ),
      ),
    );
  }
}
