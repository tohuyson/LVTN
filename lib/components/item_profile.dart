import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemProfile extends StatelessWidget {
  final String title;
  final String description;

  ItemProfile({this.title, this.description});

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

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400,color: Colors.black38),
                )
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
