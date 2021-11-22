import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBegin extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding:
              EdgeInsets.only(left: 24.w, right: 12.w, top: 8.w, bottom: 8.w),
          child: Text(
            'Bạn đang tìm kiếm nhà hàng, món ăn?',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        Wrap(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Cơm Số 1'),
                onPressed: () {
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('DVC Cơm sinh viên'),
                onSelected: (bool value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Cơm Chiên sườn'),
                onSelected: (bool value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Nước Mía'),
                onSelected: (bool value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Nước Tăng Lực'),
                onSelected: (bool value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Nước Cam'),
                onSelected: (bool value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.sp),
              child: InputChip(
                label: Text('Feel Coffee'),
                onSelected: (bool value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
