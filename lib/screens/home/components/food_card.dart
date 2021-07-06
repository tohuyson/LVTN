import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCard extends StatelessWidget {
  final Food? food;

  FoodCard({this.food});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding:EdgeInsets.only(
      left: 10.w,
        right: 10.w,
        top: 6.h,
        bottom: 4.h,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        border: Border(bottom: BorderSide(width: 4, color: kPrimaryColorBackground))
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: Image.network(
              food!.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250.h,
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            width: double.infinity,
            // color: Colors.amber,
            // padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cơm sườn",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Bữa trưa",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Cơm số 1",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      "30000VND",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFfb3132),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFfb3132),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFfb3132),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFfb3132),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFF9b9b9c),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("(200)")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
