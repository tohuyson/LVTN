import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemProfile extends StatelessWidget {
  final String name_function;
  ItemProfile({this.name_function});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Center(
              child: Text(
                name_function,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ),
            ),
          ),
          IconButton(onPressed: () {
            print('hahaha');
          }, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
