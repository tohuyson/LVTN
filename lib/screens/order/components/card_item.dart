import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CardItem();
  }
}

class _CardItem extends State<CardItem> {

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        width: 414.w,
        height: 100.h,
        margin: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 6.w, right: 6.w),
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://cdn.shortpixel.ai/client/q_glossy,ret_img/https://www.tech7.vn/wp-content/uploads/2019/11/photo-1-15737325683221621163088.jpg',
              height: 80.h,
              width: 80.w,
              fit: BoxFit.cover,
            ),
            Container(
              width: 298.w,
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 286.w,
                      child: Text(
                        'Cơm số 1',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                      width: 286.w,
                      child: Text(
                        'só 1 Đạik học hông lâm',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black45),
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                      width: 286.w,
                      child: Text(
                        '20000đ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: IconSlideAction(
            caption: 'Delete',
            color: Color(0xFFEEEEEE),
            icon: Icons.delete,
            foregroundColor: Colors.red,
            onTap: () {},
          ),
        )
      ],
    );
  }
}
