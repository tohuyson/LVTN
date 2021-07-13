import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/model/item_profile.dart';
import 'package:fooddelivery/screens/profile/avatar.dart';
import 'package:fooddelivery/screens/profile/item_profile.dart';
import 'package:get/get.dart';

class InformationUser extends GetView<ProfileController> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Thông tin người dùng"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5.h),
          color: Color(0xFFEEEEEE),
          height: 834.h,
          width: double.infinity,
          child: Column(
            children: [
              Avatar(),
              Container(
                color: Color(0xFFEEEEEE),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 0.2, color: Colors.black12))),
                      child: ItemProfile(
                        itemProfile: ItemProfileModel(
                          title: 'Tên người dùng',
                          description: controller.user.value.username,
                        ),
                      ),
                    ),
                    ItemProfile(
                      itemProfile: ItemProfileModel(
                        title: 'Số điện thoại',
                        description: controller.user.value.phone,
                      ),
                    ),
                    ItemInfor(
                      title: 'Email',
                      description: controller.user.value.email,
                    ),
                    ItemProfile(
                      itemProfile: ItemProfileModel(
                        title: 'Giới tính',
                        description: controller.user.value.bio != null &&
                                controller.user.value.bio != ''
                            ? controller.user.value.bio
                            : 'Nhập giới tính',
                      ),
                    ),
                    ItemProfile(
                      itemProfile: ItemProfileModel(
                        title: 'Ngày sinh',
                        description: controller.user.value.dob != null &&
                                controller.user.value.dob != ''
                            ? controller.user.value.dob
                            : 'Nhập ngày sinh',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ItemInfor extends StatelessWidget {
  String? title;
  String? description;

  ItemInfor({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 10.w),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.3, color: Colors.black12))),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              title!,
              style: TextStyle(fontSize: 17.sp),
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // Get.to(itemProfile!.page);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 14,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
