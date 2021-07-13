// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fooddelivery/constants.dart';
// import 'package:fooddelivery/model/order.dart';
//
// class OrderItem extends StatelessWidget {
//   final List<Order>? listOrder;
//
//   OrderItem({this.listOrder});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         for (Order order in listOrder!)
//           order.status!
//               ? InkWell(
//                   onTap: () {},
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       left: 10.w,
//                       right: 10.w,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                               width: 4, color: kPrimaryColorBackground)),
//                       color: Colors.white,
//                     ),
//                     width: double.infinity,
//                     height: 130.h,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 24.h,
//                           padding: EdgeInsets.only(
//                               left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
//                           child: Text(
//                             order.category!,
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 100.h,
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(4)),
//                                 child: Image.network(
//                                   '',
//                                   // order.restaurant!.listImage![0].url,
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   padding:
//                                       EdgeInsets.only(left: 10.w, right: 10.w),
//                                   height: 106.h,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Text(
//                                         order.restaurant!.name!,
//                                         style: TextStyle(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                       AutoSizeText(
//                                         order.restaurant!.address!,
//                                         overflow: TextOverflow.clip,
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                       Text(order.price.toString() +
//                                           'đ' +
//                                           '(' +
//                                           order.listFood!.length.toString() +
//                                           ' phần)'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : SizedBox(),
//       ],
//     );
//   }
// }
