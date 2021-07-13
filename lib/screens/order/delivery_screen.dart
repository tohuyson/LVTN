// import 'package:flutter/material.dart';
// import 'package:fooddelivery/constants.dart';
// import 'package:fooddelivery/model/order.dart';
// import 'package:fooddelivery/screens/order/components/delivery_item.dart';
// import 'package:fooddelivery/screens/order/components/delivery_map.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fooddelivery/screens/order/model/delivery_model.dart';
//
// class DeliveryScreen extends StatelessWidget {
//   final Order? order;
//
//   DeliveryScreen({this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text('Nhận đơn'),
//         centerTitle: true,
//       ),
//       body: Container(
//         height: 834.h,
//         child: Column(
//           children: [
//             DeliveryMap(
//               height: 550,
//             ),
//             Container(
//               height: 248.h,
//               color: Colors.white,
//               padding: EdgeInsets.only(left: 12.w, right: 12.w,),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 35.h,
//                     decoration: BoxDecoration(
//                       border: Border(bottom: BorderSide(color: kPrimaryColorBackground, width: 2))
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Order ID: ' + order!.id.toString(),
//                           style: TextStyle(fontSize: 15.sp),
//                         ),
//                         InkWell(
//                             onTap: () {},
//                             child: Text(
//                               'Chi tiết',
//                               style: TextStyle(fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   DeliveryItem(
//                     deliveryModel: DeliveryModel(
//                       iconData: Icons.restaurant_menu,
//                       name: order!.restaurant!.name,
//                       address: order!.restaurant!.address,
//                     ),
//                   ),
//                   DeliveryItem(
//                     deliveryModel: DeliveryModel(
//                       iconData: Icons.home,
//                       name: order!.user!.username,
//                       address: order!.user!.listAddress![1].address,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.access_alarm),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('10:30'),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.send),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('1.5km'),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         width: 46.w,
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 12.h),
//                     child: InkWell(
//                       onTap: () {},
//                       child: Container(
//                         height: 35.h,
//                         width: 380.w,
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Center(
//                           child: Text(
//                             'Đang giao'.toUpperCase(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
