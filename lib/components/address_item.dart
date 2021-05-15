import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddressItem extends StatelessWidget {
  final String addressdetail;
  final String address;
  final String username;
  final String phone;

  AddressItem({this.addressdetail, this.address, this.username, this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.h,
        margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        // color: Color(0xFFF1F1F1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(width: 0, color: Colors.black12),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                    size: 32.sp,
                  ),
                  onPressed: () {
                    print("Map");
                  }),
              Container(
                // width: 295.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                     addressdetail,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    AutoSizeText(
                     address,
                      // overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Text(
                          username,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Text(phone, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: Text(
                  'Sửa',
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
