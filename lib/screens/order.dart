import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/list_widget.dart';
import 'package:fooddelivery/components/order_item.dart';
import 'package:fooddelivery/components/three_button_horizontal.dart';

class Order extends StatelessWidget {
  final int selectedIndex;

  Order(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    List<OrderItem> list=[
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
      OrderItem(category:'Đồ ăn', namefood: 'Cơm sườn',address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',price: 18000,),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Đơn hàng',style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 22.sp, color: Colors.black
          ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: Column(
          children: [
            ButtonHorizontal(txtbt1: 'Đang đến', txtbt2: 'Lịch sử',txtbt3: 'Đơn nháp',),
           ListWidget(list),
          ],
        ),
      ),
    );
  }
}
