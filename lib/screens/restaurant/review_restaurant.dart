import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/review.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReviewRestaurant extends StatefulWidget {
  final int restaurantId;

  ReviewRestaurant({required this.restaurantId});

  @override
  State<StatefulWidget> createState() {
    return _ReviewRestaurant(restaurantId: restaurantId);
  }
}

class _ReviewRestaurant extends State<ReviewRestaurant> {
  final int restaurantId;
  RxList<Review> listReview = new RxList<Review>();

  _ReviewRestaurant({required this.restaurantId});

  @override
  void initState() {
    fetchReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 414.w,
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Obx(
        () => ListView.builder(
            itemCount: listReview.length,
            itemBuilder: (context, index) {
              return Container(
                width: 390.w,
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    listReview[index].user!.avatar! != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              Apis.baseURL + listReview[index].user!.avatar!,
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset('assets/images/user.png'),
                    Container(
                      width: 340.w,
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listReview[index].user!.username!,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          SizedBox(height: 5.h,),
                          RatingBar.builder(
                            ignoreGestures: true,
                            wrapAlignment: WrapAlignment.center,
                            initialRating:
                                double.parse(listReview[index].rate!),
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18.sp,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double value) {},
                          ),
                          SizedBox(height: 10.h,),
                          Text(listReview[index].review!, style: TextStyle(fontSize: 16.w),),
                          SizedBox(height: 10.h,),
                          listReview[index].image![0].url != null
                              ? Image.network(
                                  Apis.baseURL +
                                      listReview[index].image![0].url!,
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                          SizedBox(height: 10.h,),
                          Text(DateFormat('yyyy-MM-dd HH:mm')
                              .format(DateTime.parse(
                              listReview[index].updatedAt!))),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> fetchReview() async {
    var list = await reviewRestaurant();
    if (list != null) {
      listReview.assignAll(list);
      listReview.refresh();
    }
  }

  Future<List<Review>?> reviewRestaurant() async {
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'restaurantId': restaurantId.toString(),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.reviewRestaurantUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        var parsedJson = jsonDecode(response.body);
        List<Review> listReview = ListReview.fromJson(parsedJson).review!;
        return listReview;
      }
      if (response.statusCode == 401) {
        return null;
      }
      if (response.statusCode == 500) {
        showToast("Hệ thống bị lỗi, Vui lòng quay lại sau!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}
