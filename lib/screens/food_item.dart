import 'package:flutter/material.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/store.dart';

class FoodItem extends StatelessWidget {
  Food food;
  Store store;

  FoodItem({this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          // padding: EdgeInsets.only(right: 8),
          itemCount: store.list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final fooditem = store.list[index];
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Column(
                  children: [
                 ClipRRect(
                   borderRadius: BorderRadius.all(Radius.circular(5)),
                   child: Image(
                     // width: 200,
                     height: 120,
                     image: AssetImage('assets/images/' + fooditem.image),
                   ),
                 ),
                    Text(
                      fooditem.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(this.store.name),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFF9b9b9c),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                fooditem.price.toString() + 'VNĐ',
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ) ;
          },
        ));
  }
}

class FoodI extends StatelessWidget {
  Food f;

  FoodI({this.f});

  @override
  Widget build(BuildContext context) {}
}
