import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Order extends StatelessWidget {
  final int selectedIndex;

  Order(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Đơn hàng',style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18.sp
          ),
          ),
        ),
      ),
    );
  }
}
