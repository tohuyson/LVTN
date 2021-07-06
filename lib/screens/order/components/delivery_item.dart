import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/order/model/delivery_model.dart';
import 'package:get/get.dart';

class DeliveryItem extends StatelessWidget {
  final DeliveryModel? deliveryModel;
  final IconData? iconData_1, iconData_2, iconData_3, iconData_4;
  final Widget? page;

  DeliveryItem(
      {this.deliveryModel,
      this.iconData_1,
      this.iconData_2,
      this.iconData_3,
      this.iconData_4,
      this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      width: 414.w,
      child: Row(
        children: [
          Container(
            width: 28.w,
            child: Icon(
              deliveryModel!.iconData,
              color: Colors.black,
              size: 28.sp,
            ),
          ),
          Container(
            width: 328.w,
            padding: EdgeInsets.only(left: 10.w),
            height: 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deliveryModel!.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: 65.w,
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              iconData_1,
                              size: 15.sp,
                            ),
                            Icon(
                              iconData_2,
                              size: 15.sp,
                            ),
                            Icon(
                              iconData_3,
                              size: 15.sp,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // width: 348.w,
                  child: Text(
                    deliveryModel!.address!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 28.w,
            child: InkWell(
                onTap: () {
                  Get.to(page);
                },
                child: Icon(
                  iconData_4,
                  size: 28.sp,
                )),
          )
        ],
      ),
    );
  }
}
