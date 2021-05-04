import 'package:flutter/material.dart';
import 'package:fooddelivery/components/food_card.dart';
import 'package:fooddelivery/components/list_food.dart';
import 'package:fooddelivery/model/FakeData.dart';
import 'package:fooddelivery/model/store.dart';

class LatestFeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 270,
      // constraints: BoxConstraints(
      //   minHeight: 150,
      //   // maxHeight: 464,
      // ),
      child: Column(
        children: [
          LatestFeedsTitle(),
          Expanded(
            child: ListFood(),
          )

        ],
      ),
    );
  }
}

class LatestFeedsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Thức ăn phổ biến",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class LatestFeedsList extends StatelessWidget {
  final Store store;

  LatestFeedsList({this.store});

  @override
  Widget build(BuildContext context) {
    // return Container(
        // constraints: BoxConstraints(maxHeight: 700, minHeight: 250),
        // width: double.infinity,
        // padding: EdgeInsets.only(left: 8, top: 4, bottom: 8),
        return ListView.builder(
          itemCount: store.list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            final fooditem = store.list[index];
            // return Padding(
            //   padding: EdgeInsets.only(right: 8),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(5),
            //       border: Border.all(width: 1, color: Colors.black12),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         ConstrainedBox(
            //           // constraints: BoxConstraints(maxHeight: 150),
            //           child: Card(
            //             semanticContainer: true,
            //             clipBehavior: Clip.antiAliasWithSaveLayer,
            //             child: Image.asset('assets/images/' + fooditem.image),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(5.0),
            //             ),
            //             elevation: 0,
            //           ),
            //         ),
            //
            //         // ClipRRect(
            //         //   borderRadius: BorderRadius.all(Radius.circular(5)),
            //         //   child: Image(
            //         //     image:  ResizeImage(AssetImage('assets/images/' + fooditem.image),height: 120, width: widthItem),
            //         //   ),
            //         // ),
            //         Container(
            //           padding: EdgeInsets.only(left: 8),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 fooditem.name,
            //                 style: TextStyle(
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.w600,
            //                     fontSize: 16),
            //               ),
            //               Text(
            //                 this.store.name,
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             Container(
            //               padding: EdgeInsets.only(left: 5),
            //               child: Row(
            //                 children: <Widget>[
            //                   Icon(
            //                     Icons.star,
            //                     size: 10,
            //                     color: Color(0xFFfb3132),
            //                   ),
            //                   Icon(
            //                     Icons.star,
            //                     size: 10,
            //                     color: Color(0xFFfb3132),
            //                   ),
            //                   Icon(
            //                     Icons.star,
            //                     size: 10,
            //                     color: Color(0xFFfb3132),
            //                   ),
            //                   Icon(
            //                     Icons.star,
            //                     size: 10,
            //                     color: Color(0xFFfb3132),
            //                   ),
            //                   Icon(
            //                     Icons.star,
            //                     size: 10,
            //                     color: Color(0xFF9b9b9c),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               // padding: EdgeInsets.only(left: 55),
            //               child: Text(fooditem.price.toString() + 'VNĐ',
            //                   style: TextStyle(
            //                       color: Color(0xFF6e6e71),
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w600)),
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // );
             return FoodCard( food: fooditem);
          },
        );
    // );
  }
}
