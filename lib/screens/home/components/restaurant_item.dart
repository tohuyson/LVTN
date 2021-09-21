import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';

class RestaurantItem extends StatefulWidget {
  final Restaurant restaurant;
  final double startLat;
  final double startLong;

  const RestaurantItem(
      {required this.restaurant,
      required this.startLat,
      required this.startLong});

  @override
  State<StatefulWidget> createState() {
    return _RestaurantItem(
        restaurant: restaurant, startLat: startLat, startLong: startLong);
  }
}

class _RestaurantItem extends State<RestaurantItem> {
  final Restaurant restaurant;
  final double startLat;
  final double startLong;

  RxDouble distance = 0.0.obs;

  _RestaurantItem({
    required this.restaurant,
    required this.startLat,
    required this.startLong,
  });

  @override
  void initState() {
    distanceRes();
    super.initState();
  }

  Future<void> distanceRes() async {
    double d = await distanceRestaurant(
        startLat,
        startLong,
        double.parse(restaurant.lattitude!),
        double.parse(restaurant.longtitude!));
    setState(() {
      distance = d.obs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.to(() => RestaurantsScreen(), arguments: {
          'restaurant_id': restaurant.id,
          'distance': distance.value
        });
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
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              child: Image.network(
                Apis.baseURL + restaurant.image!,
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
              ),
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
                    restaurant.name!,
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
                            Text(restaurant.rating!),
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
                            Text('$distance km'),
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
