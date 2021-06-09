import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/users.dart';

class AddressItem extends StatelessWidget {
  final Users users;

  AddressItem({this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Address address in users.listAddress)
          Container(
            height: 80.h,
            padding:
                EdgeInsets.only(top: 4.h, bottom: 4.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom:
                        BorderSide(color: kPrimaryColorBackground, width: 4))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 28.sp,
                      ),
                      onPressed: () {
                        print("Map");
                      }),
                  Container(
                    width: 290.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          address.addressDetail,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        AutoSizeText(
                          address.address,
                          // overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Text(
                              users.name,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              users.phone,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16.sp),
                            ),
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
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
