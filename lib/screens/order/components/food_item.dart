
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/toppings.dart';

class FoodItem extends StatelessWidget {
  final Map<int, Food> map;
  static int i;

  FoodItem({this.map});

  @override
  Widget build(BuildContext context) {
    // print(order.listFood.length);
    // print('$i dsad');
    return Column(
      children: [
        for (i = 0; i < map.length; i++)
          Container(
            padding:
                EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  child: Image.network(
                    map.values.elementAt(i).image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 24.w,
                  child: Text('x ' + map.keys.elementAt(i).toString()),
                ),
                Container(
                  width: 230.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        map.values.elementAt(i).name,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      map.values.elementAt(i).size == null
                          ? SizedBox()
                          : Text(
                              'Size ' + map.values.elementAt(i).size.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                      map.values.elementAt(i).listTopping == null
                          ? Text('')
                          : Column(
                              children: [
                                for (Topping topping
                                    in map.values.elementAt(i).listTopping)
                                  topping.name == null
                                      ? Text('')
                                      : Text(topping.name),
                              ],
                            )
                    ],
                  ),
                ),
                Container(
                  width: 70.w,
                  child: Text(
                    sumPrice(map.values.elementAt(i), map.keys.elementAt(i))
                            .toStringAsFixed(0) +
                        'đ',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  double sumPriceTopping(List<Topping> list) {
    double sum = 0;
    if (list == null) return sum;
    for (Topping topping in list) sum += topping.price;

    return sum;
  }

  double priceOfItem(Food food) {
    double sum = 0;
    if (food.size == null)
      return sum += food.price + sumPriceTopping(food.listTopping);
    sum += food.price + food.size.price + sumPriceTopping(food.listTopping);

    return sum;
  }

  double sumPrice(Food food, int numberItem) {
    return priceOfItem(food) * numberItem;
  }
}
