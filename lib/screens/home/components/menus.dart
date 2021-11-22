import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/home/menu_screen.dart';
import 'package:get/get.dart';
import 'package:fooddelivery/model/item_category.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 184.h,
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: listItemCategory.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(MenuScreen(),
                      arguments: {'menuName': listItemCategory[index].name!});
                },
                child: Container(
                  height: 84.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xFFEFEFEF)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 40.h,
                        width: 40.w,
                        child: Image.asset('assets/icons_menu/' +
                            listItemCategory[index].url!),
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          listItemCategory[index].name!,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
