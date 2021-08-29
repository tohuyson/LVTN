import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/card.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/toppings.dart';

class FoodItem extends StatelessWidget {
  late CardModel? cardModel;
  static int? i;

  FoodItem({this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: cardModel!.cardOrder!.length,
        itemBuilder: (context, index) {
          return Container(
            padding:
                EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  child: Image.network(
                    Apis.baseURL +
                        cardModel!.cardOrder![index].food!.images![0].url!,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 24.w,
                  child: Text('x ${cardModel!.cardOrder![index].quantity}'),
                ),
                Container(
                  width: 230.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cardModel!.cardOrder![index].food!.name}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cardModel!.cardOrder![index].toppings!.length,
                          itemBuilder: (context, i) {
                            return Text(
                                '${cardModel!.cardOrder![index].toppings![i].name}');
                          }),
                    ],
                  ),
                ),
                Container(
                  width: 70.w,
                  child: Text(
                    '${cardModel!.cardOrder![index].price}',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
