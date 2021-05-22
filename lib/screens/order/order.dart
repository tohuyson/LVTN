import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/components/three_button_horizontal.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/screens/order/order_item.dart';

class OrderScreen extends StatelessWidget {
 static Food food;
 static List<Order> list;

  @override
  Widget build(BuildContext context) {
    food = new Food(id:1,name: 'Hủ tiếu', image:  'https://chupanhmonan.com/wp-content/uploads/2018/10/chup-anh-mon-an-chuyen-nghiep-tu-liam-min-min.jpg',price: 25000, );
    list = [
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
      Order(
        category: 'Đồ ăn',
        namefood: food,
        address: 'Trường DH nông lâm TP, linh trung thủ đức , hồ chí minh',
        price: 18000,
        method: 'Thanh toán bằng tiền mặt',
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        width: double.infinity,
        height: 834.h,
        child: Column(
          children: [
            ButtonHorizontal(
              txtbt1: 'Đang đến',
              txtbt2: 'Lịch sử',
              txtbt3: 'Đơn nháp',
            ),
            Expanded(
                child: ListView(
              children: [
                for (Order o in list)
                  OrderItem(
                    order: o,
                  )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
