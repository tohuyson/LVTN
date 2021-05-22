import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/three_button_horizontal.dart';
import 'package:fooddelivery/model/notify.dart';
import 'package:fooddelivery/screens/notify/notify_item.dart';

class NotifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Notify> list = [
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
      Notify(
        title: 'Giao hàng',
        content: 'Giao đơn hàng thành công',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Thông báo',
          style: TextStyle(
              color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: () {
                print("Map");
              }),
        ],
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        height: 834.h,
        child: Column(
          children: [
            ButtonHorizontal(
              txtbt1: 'Chưa đọc',
              txtbt2: 'Đơn hàng',
              txtbt3: 'Tất cả',
            ),
            Expanded(child: ListView(
              children: [
                for( Notify n in list) NotifyItem(notify: n,)
              ],
            )),
          ],
        ),
      ),
    );
  }
}
