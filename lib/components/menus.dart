import 'package:flutter/material.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.7,
      // padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 5
        // ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          // childAspectRatio: 1 / 2,
          // crossAxisSpacing: 20,
          // mainAxisSpacing: 20
        ),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: menus.length,
        itemBuilder: (_, index) {
          return Container(
            // margin: EdgeInsets.only(top: 5),
            // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: 70.h,
            width: 70.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFEFEFEF)),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/icons_menu/' + menus[index].url),
                ),
                Text(menus[index].name)
              ],
            ),
          );
        },
      ),
    );
  }
}
