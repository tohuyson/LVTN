import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/controllers/address_controller.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:get/get.dart';

class AddressItem extends GetView<AddressController> {
  AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return controller.listAddress == null
        ? Obx(
            () => ListView.builder(
                itemCount: controller.listAddress.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80.h,
                    padding: EdgeInsets.only(
                        top: 4.h, bottom: 4.h, left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: kPrimaryColorBackground, width: 4))),
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
                                  controller.listAddress[index].address!,
                                  // address.addressDetail!,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      controller.users.value.username!,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      controller.users.value.phone!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp),
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
                  );
                }),
          )
        : Container(
            color: Colors.white,
            child: Center(
              child: Text('Bạn chưa có địa chỉ'),
            ),
          );
  }
}
