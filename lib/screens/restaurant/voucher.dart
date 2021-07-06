import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';

class Voucher extends StatelessWidget {
  Widget voucherItem(context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      width: 414.w,
      // height: 104.h,
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 5.w, top: 5.w),
      child: Row(
        children: [
          Image.network(
            'https://svoucher.vn/wp-content/uploads/2019/09/gift-voucher.jpg',
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
          Container(
            width: 310.w,
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  // width: 298.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'FreeShip cho đơn 60k',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      // Radio(
                      //   value: 1,
                      //   onChanged: (int? value) {
                      //   },
                      //   groupValue: null,
                      // )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 16.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Text(
                              'Hết hạn sau 3 ngày',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Điều kiện',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor),
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
        child: Column(
          children: [
            voucherItem(context),
            voucherItem(context),
          ],
        ),
      ),
    );
  }
}
