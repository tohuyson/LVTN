import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/function_profile.dart';
import 'package:get/get.dart';

class ItemProfile extends StatelessWidget {
  final FunctionProfile? functionProfile;

  ItemProfile({this.functionProfile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.to(functionProfile!.widget);
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Center(
                child: Text(
                  functionProfile!.name,
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await Get.to(functionProfile!.widget);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ))
          ],
        ),
      ),
    );
  }
}
