import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/categories.dart';
import 'package:fooddelivery/model/FakeData.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.7,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),

      // child: GridView.builder(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 5,
      //     ),
      //     shrinkWrap: true,
      //     physics: ScrollPhysics(),
      //     itemCount: menus.length ,
      //     scrollDirection: Axis.horizontal,
      //     itemBuilder: (_, index) {
      //       final category = menus[index];
      //       return Container(
      //         height: 50,
      //         width: 50,
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             // borderRadius: BorderRadius.all(Radius.circular(50))
      //         ),
      //         child:  Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               // padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      //               // width: MediaQuery.of(context).size.width / 5.5,
      //               // height:MediaQuery.of(context).size.height ,
      //               child: Card(
      //                 shape: BeveledRectangleBorder(
      //                   borderRadius: BorderRadius.circular(2.0),
      //                 ),
      //                 child: Container(
      //                   // constraints: BoxConstraints(
      //                   //   minWidth: 45,
      //                   //   maxWidth: 50,
      //                   //   minHeight: 45,
      //                   //   maxHeight: 50,
      //                   // ),
      //                   // width: 47,
      //                   // height: 47,
      //                   // height: MediaQuery.of(context).size.height /12 ,
      //                   child: Center(
      //                     child: Image.asset(
      //                       'assets/icons_menu/' + category.url,
      //                       width: 34,
      //                       height: 34,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Text(
      //               category.name,
      //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      //             )
      //           ],
      //         ),
      //       );
      //     }),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 5
        // ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            // childAspectRatio: 1 / 2,
            // crossAxisSpacing: 20,
            // mainAxisSpacing: 20
        ),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: menus.length,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            height: 80,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  child: Image.asset('assets/icons_menu/' + menus[index].url),
                ),
                Text(menus[index].name)
              ],
            ),
          );
        },
      ),
    );
  }
}
