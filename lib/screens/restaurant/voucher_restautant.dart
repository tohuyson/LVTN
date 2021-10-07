import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/discount.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class VoucherRestaurant extends StatefulWidget {
  final int restaurantId;

  VoucherRestaurant({required this.restaurantId});

  @override
  State<StatefulWidget> createState() {
    return _VoucherRestaurant(restaurantId: restaurantId);
  }
}

class _VoucherRestaurant extends State<VoucherRestaurant> {
  final int restaurantId;
  late RxList<Discount> listDiscount;

  _VoucherRestaurant({required this.restaurantId});

  @override
  void initState() {
    listDiscount = new RxList<Discount>();
    fetchDiscount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      width: 414.w,
      child: Obx(
        () => ListView.builder(
            itemCount: listDiscount.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 0.5))),
                width: 390.w,
                padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sell_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          listDiscount[index].name!,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 390.w,
                      child: Text(
                          'Giảm: ${listDiscount[index].percent}% - Mã: ${listDiscount[index].code}'),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 390.w,
                      child: Text(
                          'Thời gian áp dụng: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(listDiscount[index].startDate!))} - ${DateFormat('yyyy-MM-dd').format(DateTime.parse(listDiscount[index].endDate!))}'),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> fetchDiscount() async {
    var discount = await getDiscount();
    if (discount != null) {
      print('vày đay k');
      listDiscount.assignAll(discount);
      listDiscount.refresh();
    }
  }

  Future<List<Discount>?> getDiscount() async {
    print(restaurantId);
    List<Discount> list;
    var token = await getToken();
    try {
      Map<String, String> queryParams = {
        'restaurant_id': restaurantId.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      http.Response response = await http.get(
        Uri.parse(Apis.getVoucherUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        print(parsedJson['discounts']);
        list = ListDiscount.fromJson(parsedJson).discounts!;
        return list;
      }
      if (response.statusCode == 500) {
        showToast("Server error, please try again later!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}
