import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:get/get.dart';

class Avatar extends GetView<ProfileController> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.getImage();
      },
      child: Container(
        color: Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              margin: EdgeInsets.all(5),
              child: Container(
                width: 60.w,
                height: 60.h,
                padding: EdgeInsets.only(
                    right: 12.w, bottom: 12.h, left: 12.w, top: 12.h),
                child: controller.user.value.avatar != null &&
                        controller.user.value.avatar != ''
                    ? Image.network(
                        Apis.baseURL + controller.user.value.avatar!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/user.png",
                        fit: BoxFit.cover,
                        color: Colors.black26,
                      ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    'Thay đổi hình đại diện',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // controller.getImage();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
