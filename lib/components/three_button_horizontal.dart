import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonHorizontal extends StatelessWidget{
  final String txtbt1;
  final String txtbt2;
  final String txtbt3;
  ButtonHorizontal({
    this.txtbt1, this.txtbt2, this.txtbt3
});
  @override
  Widget build(BuildContext context) {
    return  Container(
      // color: Color(0xFFEEEEEE),
      height: 50.h,
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
            },
            child: Container(
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  txtbt1,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Container(
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                 txtbt2,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Container(
              height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                 txtbt3,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}