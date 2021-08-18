import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:get/get.dart';

class SearchBody extends StatelessWidget {
  final Restaurant? restaurant;

  const SearchBody({this.restaurant});

  Widget buildBook(Restaurant restaurant) => GestureDetector(
        onTap: () {
          Get.to(RestaurantsScreen(),
              arguments: {'restaurant_id': restaurant.id});
        },
        child: Container(
          width: 414.w,
          color: Colors.white,
          padding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
          margin:
              EdgeInsets.only(bottom: 4.h, top: 4.h, left: 12.w, right: 12.w),
          height: 96.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                Apis.baseURL + restaurant.image!,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        restaurant.name!,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // Container(
                    //     width: 300.w,
                    //     child: Text(
                    //       'Giá: ' + food.price.toString() + 'đ',
                    //       style: TextStyle(
                    //           fontSize: 16.sp, fontWeight: FontWeight.w400),
                    //     )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(restaurant.rating!),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColorBackground,
      child: buildBook(restaurant!),
    );
  }
}
