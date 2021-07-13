import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:get/get.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant? restaurant;

  RestaurantItem({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => RestaurantsScreen(), arguments: {'id': restaurant!.id});
      },
      child: Container(
        width: 414.w,
        height: 120.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: kPrimaryColorBackground))),
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 6.h, bottom: 6.h),
        child: Row(
          children: [
            Image.network(
              Apis.baseURL + restaurant!.image!,
              fit: BoxFit.cover,
              width: 100.w,
              height: 100.h,
            ),
            Container(
              width: 286.w,
              padding: EdgeInsets.only(
                left: 8.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant!.name!,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                    overflow: TextOverflow.clip,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(restaurant!.rating!),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.near_me,
                              size: 16,
                              color: Colors.black26,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text('2.5 km'),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
