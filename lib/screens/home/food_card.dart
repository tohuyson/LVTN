import 'package:flutter/material.dart';
import 'package:fooddelivery/model/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  FoodCard({this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Image.network(
                'https://aphoto.vn/wp-content/uploads/2019/03/avata-19.jpg',
                width: double.infinity,
              ),
            ),
            Container(
              color: Colors.black12,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              width: double.infinity,
              // color: Colors.amber,
              // padding: EdgeInsets.only(left: 4, right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cơm sườn",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Bữa trưa",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Cơm số 1",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        "30000VND",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    ],
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
