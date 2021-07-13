import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/controllers/auth_controller.dart';
import 'package:fooddelivery/controllers/profile_controllor.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/item_profile.dart';
import 'package:fooddelivery/screens/home/home_screen.dart';
import 'package:fooddelivery/screens/profile/avatar.dart';
import 'package:fooddelivery/screens/profile/information_user.dart';
import 'package:fooddelivery/screens/profile/item_profile.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Tôi'),
      ),
      body: ListView(
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.only(top: 40.h),
            height: 210.h,
            child: InkWell(
              onTap: () {
                Get.to(InformationUser());
              },
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      width: 100.w,
                      height: 100.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),

                        // padding: EdgeInsets.only(
                        //     right: 12.w, bottom: 12.h, left: 12.w, top: 12.h),
                        // decoration: BoxDecoration(
                        //   border: Border.all(width: 1, color: Colors.black12),
                        //   borderRadius: BorderRadius.all(Radius.circular(50)),
                        // ),
                        child: controller.user.value.avatar != null &&
                                controller.user.value.avatar != ''
                            ? Image.network(
                                Apis.baseURL + controller.user.value.avatar!,
                                fit: BoxFit.cover,
                                // color: Colors.black26,
                              )
                            : Image.asset(
                                "assets/images/user.png",
                                fit: BoxFit.cover,
                                color: Colors.black26,
                              ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Obx(
                      () => Text(
                        controller.user.value.username!,
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Thanh toán',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Địa chỉ',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Người giao hàng',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Đơn hàng của tôi',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                // ColorLineBottom(),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Trung tâm hỗ trợ',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Chính sách và quy định',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
                ItemProfile(
                  itemProfile: ItemProfileModel(
                    title: 'Cài đặt',
                    description: '',
                    page: HomeScreen(),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.logout();
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: 30.h, bottom: 10.h, left: 12.w, right: 12.w),
              height: 45.h,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  'Đăng xuất'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
