import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  final String category;
  final String namefood;
  final String address;
  final double price;

  OrderItem({this.category, this.namefood, this.address, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w,top: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 120.h,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 2.w, right: 2.w, top:2.h,bottom: 2.h),
            child: Text(
              category,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: Image.network(
                  'https://chupanhmonan.com/wp-content/uploads/2018/10/chup-anh-mon-an-chuyen-nghiep-tu-liam-min-min.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 0),
                  height: 92.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        namefood,
                        style:
                            TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        address,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black38,
                        ),
                      ),
                      Text(price.toString()+ 'đ'),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
