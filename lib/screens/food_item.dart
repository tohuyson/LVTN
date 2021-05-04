import 'package:flutter/material.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/store.dart';
import 'package:fooddelivery/screens/food_detail.dart';

class FoodItem extends StatelessWidget {
  Store store;
  int widthItem = 190;

  FoodItem({ this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.only(left: 8, top: 4, bottom: 8),
        child: ListView.builder(
          itemCount: store.list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final fooditem = store.list[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context)=> FoodDetail(food: fooditem,)),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Container(
                  width: double.tryParse(widthItem.toString()),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          image: ResizeImage(AssetImage(
                              'assets/images/' + fooditem.image), height: 120,
                              width: widthItem),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fooditem.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            Text(
                              this.store.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              children: <Widget>[
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
                            padding: EdgeInsets.only(left: 55),
                            child: Text(fooditem.price.toString() + 'VNĐ',
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class FoodItemTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popluar Foods",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
          ),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }
}
