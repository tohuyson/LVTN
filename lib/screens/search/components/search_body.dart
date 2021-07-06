import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBody extends StatelessWidget {
  final List<Food>? foods;

  const SearchBody({Key? key, this.foods}) : super(key: key);

  Widget buildBook(Food food) => Container(
        width: 414.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 8.h),
        margin: EdgeInsets.only(bottom: 8.h),
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              food.image!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.only(left: 12.w),
              width: 310.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300.w,
                      child: Text(food.name!, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),)),
                  Container(
                      width: 300.w,
                      child: Text('Giá: '+food.price.toString()+ 'đ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFfb3132),
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFfb3132),
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFfb3132),
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFfb3132),
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFF9b9b9c),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("(200)")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColorBackground,
      child: ListView.builder(
        itemCount: foods!.length,
        itemBuilder: (context, index) {
          final food = foods![index];

          return buildBook(food);
        },
      ),
    );
  }
}
