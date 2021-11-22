import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Payment();
  }
}

class _Payment extends State<Payment> {
  late String group;

  @override
  void initState() {
    group = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phương thức thanh toán'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 414.w,
            padding: EdgeInsets.only(
                bottom: 12.h, left: 12.w, right: 12.w, top: 12.h),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: kPrimaryColorBackground, width: 2))),
            child: Text(
              'Chọn 1 hình thức thanh toán',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: kPrimaryColorBackground, width: 2))),
                  padding: EdgeInsets.only(bottom: 12.h),
                  width: 414.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 34.sp,
                            ),
                          ),
                          Text(
                            'Tiền mặt',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      new Radio(
                        toggleable: true,
                        value: 'Tiền mặt',
                        groupValue: group.toString(),
                        onChanged: (val) {
                          setState(() {
                            group = val.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: kPrimaryColorBackground, width: 2))),
                  padding: EdgeInsets.only(bottom: 12.h),
                  width: 414.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 34.sp,
                            ),
                          ),
                          Text(
                            'ZaloPay',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      new Radio(
                        toggleable: true,
                        value: 'Zalopay',
                        groupValue: group.toString(),
                        onChanged: (val) {
                          setState(() {
                            group = val.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (group != null || group != '') {
            Get.back(result: new RxString(group));
          } else
            Get.back(result: new RxString(''));
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
}
