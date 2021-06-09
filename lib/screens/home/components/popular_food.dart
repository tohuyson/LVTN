import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/screens/home/components/food_card.dart';


class PopularFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.only(top: 6.h),
      width: double.infinity,
      child: Column(
        children: [
          LatestFeedsTitle(),
          for (Food f in listFoodOrder.values) FoodCard(food: f),
        ],
      ),
    );
  }
}

class LatestFeedsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.h,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Thức ăn phổ biến",
            style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
