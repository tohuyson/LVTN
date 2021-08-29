import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/discount.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Voucher extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Voucher();
  }
}

class _Voucher extends State<Voucher> {
  late RxList<Discount> list;
  late int restaurant_id;
  late String group;
  late String percent;
  late Discount discount;

  @override
  void initState() {
    discount = new Discount();
    group = '';
    percent = '';
    list = RxList<Discount>();
    restaurant_id = Get.arguments['restaurant_id'];
    print(restaurant_id);
    fetchDiscount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text('Voucher'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(45.h),
            child: Container(
              margin: EdgeInsets.all(12.w),
              width: 414.w,
              height: 45.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45.h,
                    width: 300.w,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Nhập mã voucher',
                        hintStyle: new TextStyle(
                          color: Colors.black38,
                          fontSize: 16.sp,
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Áp dụng'),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Container(
        color: kPrimaryColorBackground,
        height: 834.h,
        width: 414.w,
        child: Obx(() => ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                width: 414.w,
                padding: EdgeInsets.only(
                    left: 12.w, right: 12.w, bottom: 5.w, top: 5.w),
                child: Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      child: Icon(Icons.sell_rounded, color: Theme.of(context).primaryColor,),
                    ),
                    Container(
                      width: 308.w,
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                              alignment: Alignment.center,
                              child: Text(
                                'Số lượng có hạn',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Theme.of(context).primaryColor),
                              )),
                          Container(
                            // width: 296.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${list[index].name}',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                new Radio(
                                  toggleable: true,
                                  value: list[index].id!.toString(),
                                  groupValue: group.toString(),
                                  onChanged: (val) {
                                    setState(() {
                                      group = val.toString();
                                      if (val == null) {
                                        discount = new Discount();
                                      } else
                                        discount = list[index];
                                      print(percent);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 296.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 236.w,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        size: 16.sp,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.w),
                                        child: Text(
                                          'Hạn sử dụng đến ngày ${list[index].endDate}',
                                          style: TextStyle(fontSize: 13.sp),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60.w,
                                  child: Text(
                                    'Điều kiện',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Sử dụng');
          Get.back(result: discount);
        },
        label: Container(
          height: 76.h,
          width: 414.w,
          color: Colors.white,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 10.h, bottom: 16.h, left: 16.w, right: 16.w),
              height: 50.h,
              width: 382.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                'Sử dụng',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              )),
        ),
      ),
    );
  }

  Future<void> fetchDiscount() async {
    var discount = await getDiscount();
    if (discount != null) {
      list.assignAll(discount);
      list.refresh();
    }
  }

  Future<List<Discount>?> getDiscount() async {
    List<Discount> list;
    var token = await getToken();
    try {
      Map<String, String> queryParams = {
        'restaurant_id': restaurant_id.toString(),
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
