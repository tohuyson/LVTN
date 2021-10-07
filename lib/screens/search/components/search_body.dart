import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchBody extends StatelessWidget {
  final Restaurant? restaurant;

  const SearchBody({this.restaurant});

  Widget buildBook(Restaurant restaurant) => GestureDetector(
        onTap: () {
          Get.to(RestaurantsScreen(),
              arguments: {'restaurant_id': restaurant.id});
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 414.w,
          // height: 200.h,

          padding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
          margin:
              EdgeInsets.only(bottom: 4.h, top: 4.h, left: 12.w, right: 12.w),
          // height: 96.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      Apis.baseURL + restaurant.image!,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12.w),
                    height: 80.h,
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
              // SizedBox(
              //   height: 8.h,
              // ),
              restaurant.foods!.length != 0
                  ? restaurant.foods!.length < 2
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90.w,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      Apis.baseURL +
                                          restaurant
                                              .foods![index].images![0].url!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(restaurant.foods![index].name!),
                                        Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(restaurant
                                                  .foods![index].price!),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              height: 50.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90.w,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      Apis.baseURL +
                                          restaurant
                                              .foods![index].images![0].url!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(restaurant.foods![index].name!),
                                        Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(restaurant
                                                  .foods![index].price!),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                  : Container(),
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
