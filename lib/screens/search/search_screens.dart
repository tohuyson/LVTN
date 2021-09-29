import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/list_restaurant.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';
import 'package:fooddelivery/screens/search/components/search_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/screens/widget/loading.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
  // List<Food>? foods;
  late TextEditingController controller = TextEditingController();

  // late RxList<Restaurant> listRestaurant;
  late RxList<ResultSearch> listSearch;
  bool isLoading = false;

  late String startLat;
  late String startLong;

  RxDouble dis = 0.0.obs;

  @override
  void initState() {
    // listRestaurant = new RxList<Restaurant>();
    listSearch = new RxList<ResultSearch>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45.h,
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            onChanged: (value) async {
              var r = await getListSearch(value);
              setState(() {
                listSearch.assignAll(r!);
                listSearch.refresh();
                isLoading = false;
              });
            },
            decoration: InputDecoration(
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              fillColor: Colors.white,
              suffixIcon: controller.text.isNotEmpty || controller.text != ''
                  ? GestureDetector(
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        controller.clear();
                        var r = await getListSearch('');
                        setState(() {
                          listSearch.assignAll(r!);
                          listSearch.refresh();
                          isLoading = false;
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
                  : GestureDetector(
                      child: Icon(Icons.search, color: Colors.black45),
                      onTap: () async {
                        print(controller.text);
                        var r = await getListSearch(controller.text);
                        setState(() {
                          listSearch.assignAll(r!);
                          listSearch.refresh();
                          isLoading = false;
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
              hintText: 'Tìm kiếm quán ăn',
              hintStyle: new TextStyle(
                color: Colors.black38,
                fontSize: 16.sp,
              ),
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          controller.text.isNotEmpty
              ? Obx(
                  () => listSearch.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 12.w,
                                  top: 8.w,
                                  bottom: 8.w),
                              child: Text(
                                'Bạn đang tìm kiếm quán ăn?',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                            Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Cơm'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Cơm');
                                      var r =
                                          await getListSearch(controller.text);
                                      setState(() {
                                        listSearch.assignAll(r!);
                                        listSearch.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Cơm sinh viên DVC'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Cơm sinh viên DVC');
                                      var r =
                                          await getListSearch(controller.text);
                                      setState(() {
                                        listSearch.assignAll(r!);
                                        listSearch.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Cơm Chiên sườn'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Cơm Chiên sườn');
                                      var r =
                                          await getListSearch(controller.text);
                                      setState(() {
                                        listSearch.assignAll(r!);
                                        listSearch.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Bún'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Bún');
                                      var r =
                                          await getListSearch(controller.text);
                                      setState(() {
                                        listSearch.assignAll(r!);
                                        listSearch.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                      label: Text('Hũ tiếu'),
                                      onPressed: () async {
                                        controller = new TextEditingController(
                                            text: 'Hũ tiếu');
                                        var r = await getListSearch(
                                            controller.text);
                                        setState(() {
                                          listSearch.assignAll(r!);
                                          listSearch.refresh();
                                          isLoading = false;
                                        });
                                      }),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.sp),
                                  child: InputChip(
                                    label: Text('Bánh canh'),
                                    onPressed: () async {
                                      controller = new TextEditingController(
                                          text: 'Bánh canh');
                                      var r =
                                          await getListSearch(controller.text);
                                      setState(() {
                                        listSearch.assignAll(r!);
                                        listSearch.refresh();
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          height: 834.h,
                          child: ListView.builder(
                              itemCount: listSearch.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(RestaurantsScreen(), arguments: {
                                      'restaurant_id': listSearch[index].id
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 414.w,
                                    // height: 200.h,

                                    padding: EdgeInsets.only(
                                        left: 12.w,
                                        right: 12.w,
                                        top: 8.h,
                                        bottom: 8.h),
                                    margin: EdgeInsets.only(
                                        bottom: 4.h,
                                        top: 4.h,
                                        left: 12.w,
                                        right: 12.w),
                                    // height: 96.h,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                Apis.baseURL +
                                                    listSearch[index].image!,
                                                width: 80.w,
                                                height: 80.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 12.w),
                                              height: 80.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      listSearch[index].name!,
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  // Container(
                                                  //     width: 300.w,
                                                  //     child: Text(
                                                  //       'Giá: ' + food.price.toString() + 'đ',
                                                  //       style: TextStyle(
                                                  //           fontSize: 16.sp, fontWeight: FontWeight.w400),
                                                  //     )),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.star,
                                                        size: 16,
                                                        color: Colors.amber,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(listSearch[index]
                                                          .rating!),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      // Text('|'),
                                                      // SizedBox(
                                                      //   width: 10.w,
                                                      // ),
                                                      // Text('${} km'),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        // restaurant.foods!.length != 0
                                        //     ? restaurant.foods!.length < 2
                                        //         ? ListView.builder(
                                        //             physics:
                                        //                 NeverScrollableScrollPhysics(),
                                        //             shrinkWrap: true,
                                        //             itemCount: 1,
                                        //             itemBuilder:
                                        //                 (context, index) {
                                        //               return Container(
                                        //                 height: 50.h,
                                        //                 child:
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 90.w,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                Apis.baseURL +
                                                    listSearch[index].url!,
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(listSearch[index]
                                                      .foodname!),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(
                                                            listSearch[index]
                                                                .price!),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        //               );
                                        //             })
                                        //         : ListView.builder(
                                        //             physics:
                                        //                 NeverScrollableScrollPhysics(),
                                        //             shrinkWrap: true,
                                        //             itemCount: 2,
                                        //             itemBuilder:
                                        //                 (context, index) {
                                        //               return Container(
                                        //                 margin: EdgeInsets
                                        //                     .symmetric(
                                        //                         vertical: 4.h),
                                        //                 height: 50.h,
                                        //                 child: Row(
                                        //                   children: [
                                        //                     SizedBox(
                                        //                       width: 90.w,
                                        //                     ),
                                        //                     ClipRRect(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5),
                                        //                       child:
                                        //                           Image.network(
                                        //                         Apis.baseURL +
                                        //                             restaurant
                                        //                                 .foods![
                                        //                                     index]
                                        //                                 .images![
                                        //                                     0]
                                        //                                 .url!,
                                        //                         width: 40,
                                        //                         height: 40,
                                        //                         fit: BoxFit
                                        //                             .cover,
                                        //                       ),
                                        //                     ),
                                        //                     Padding(
                                        //                       padding: EdgeInsets
                                        //                           .only(
                                        //                               left:
                                        //                                   10.w),
                                        //                       child: Column(
                                        //                         mainAxisAlignment:
                                        //                             MainAxisAlignment
                                        //                                 .spaceBetween,
                                        //                         crossAxisAlignment:
                                        //                             CrossAxisAlignment
                                        //                                 .start,
                                        //                         children: [
                                        //                           Text(restaurant
                                        //                               .foods![
                                        //                                   index]
                                        //                               .name!),
                                        //                           Text(
                                        //                             NumberFormat.currency(
                                        //                                     locale:
                                        //                                         'vi')
                                        //                                 .format(restaurant
                                        //                                     .foods![index]
                                        //                                     .price!),
                                        //                             style: TextStyle(
                                        //                                 fontSize: 14
                                        //                                     .sp,
                                        //                                 fontWeight:
                                        //                                     FontWeight.w500),
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               );
                                        //             })
                                        //     : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 24.w, right: 12.w, top: 8.w, bottom: 8.w),
                      child: Text(
                        'Bạn đang tìm kiếm quán ăn?',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Cơm'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Cơm');
                              var r = await getListSearch(controller.text);
                              setState(() {
                                listSearch.assignAll(r!);
                                listSearch.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Cơm sinh viên DVC '),
                            onPressed: () async {
                              controller = new TextEditingController(
                                  text: 'Cơm sinh viên DVC ');
                              var r = await getListSearch(controller.text);
                              setState(() {
                                listSearch.assignAll(r!);
                                listSearch.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Cơm Chiên sườn'),
                            onPressed: () async {
                              controller = new TextEditingController(
                                  text: 'Cơm Chiên sườn');
                              var r = await getListSearch(controller.text);
                              setState(() {
                                listSearch.assignAll(r!);
                                listSearch.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Bún'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Bún');
                              var r = await getListSearch(controller.text);
                              setState(() {
                                listSearch.assignAll(r!);
                                listSearch.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                              label: Text('Hũ tiếu'),
                              onPressed: () async {
                                controller =
                                    new TextEditingController(text: 'Hũ tiếu');
                                var r = await getListSearch(controller.text);
                                setState(() {
                                  listSearch.assignAll(r!);
                                  listSearch.refresh();
                                  isLoading = false;
                                });
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.sp),
                          child: InputChip(
                            label: Text('Bánh canh'),
                            onPressed: () async {
                              controller =
                                  new TextEditingController(text: 'Bánh canh');
                              var r = await getListSearch(controller.text);
                              setState(() {
                                listSearch.assignAll(r!);
                                listSearch.refresh();
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          isLoading
              ? Center(
                  child: Container(
                      width: 50.w,
                      height: 50.h,
                      color: Colors.transparent,
                      child: const Loading()),
                )
              : Container(),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Container(
    //       height: 45.h,
    //       child: TextField(
    //         controller: controller,
    //         textCapitalization: TextCapitalization.sentences,
    //         autofocus: true,
    //         onChanged: (value) async {
    //           var r = await getRestaurants(value);
    //           setState(() {
    //             listRestaurant.assignAll(r!);
    //             listRestaurant.refresh();
    //             isLoading = false;
    //           });
    //         },
    //         decoration: InputDecoration(
    //           filled: true,
    //           enabledBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(2.0)),
    //             borderSide: BorderSide(color: Colors.black26),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(2.0)),
    //             borderSide: BorderSide(color: Colors.blue),
    //           ),
    //           fillColor: Colors.white,
    //           suffixIcon: controller.text.isNotEmpty || controller.text != ''
    //               ? GestureDetector(
    //             child: Icon(
    //               Icons.close,
    //               color: Colors.black,
    //             ),
    //             onTap: () async {
    //               controller.clear();
    //               var r = await getRestaurants('');
    //               setState(() {
    //                 listRestaurant.assignAll(r!);
    //                 listRestaurant.refresh();
    //                 isLoading = false;
    //               });
    //               FocusScope.of(context).requestFocus(FocusNode());
    //             },
    //           )
    //               : GestureDetector(
    //             child: Icon(Icons.search, color: Colors.black45),
    //             onTap: () async {
    //               print(controller.text);
    //               var r = await getRestaurants(controller.text);
    //               setState(() {
    //                 print(r!.length);
    //                 listRestaurant.assignAll(r);
    //                 listRestaurant.refresh();
    //               });
    //               FocusScope.of(context).requestFocus(FocusNode());
    //             },
    //           ),
    //           hintText: 'Tìm kiếm quán ăn',
    //           hintStyle: new TextStyle(
    //             color: Colors.black38,
    //             fontSize: 16.sp,
    //           ),
    //           contentPadding: EdgeInsets.all(15),
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: Stack(
    //     children: [
    //       controller.text.isNotEmpty
    //           ? Obx(
    //             () => listRestaurant.length == 0
    //             ? Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: double.infinity,
    //               padding: EdgeInsets.only(
    //                   left: 24.w,
    //                   right: 12.w,
    //                   top: 8.w,
    //                   bottom: 8.w),
    //               child: Text(
    //                 'Bạn đang tìm kiếm quán ăn?',
    //                 style: TextStyle(fontSize: 18.sp),
    //               ),
    //             ),
    //             Wrap(
    //               children: [
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                     label: Text('Cơm'),
    //                     onPressed: () async {
    //                       controller = new TextEditingController(
    //                           text: 'Cơm');
    //                       var r =
    //                       await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                     label: Text('DVC Cơm sinh viên'),
    //                     onPressed: () async {
    //                       controller = new TextEditingController(
    //                           text: 'DVC Cơm sinh viên');
    //                       var r =
    //                       await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                     label: Text('Cơm Chiên sườn'),
    //                     onPressed: () async {
    //                       controller = new TextEditingController(
    //                           text: 'Cơm Chiên sườn');
    //                       var r =
    //                       await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                     label: Text('Bún'),
    //                     onPressed: () async {
    //                       controller = new TextEditingController(
    //                           text: 'Bún');
    //                       var r =
    //                       await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                       label: Text('Hủ tiếu'),
    //                       onPressed: () async {
    //                         controller = new TextEditingController(
    //                             text: 'Hủ tiếu');
    //                         var r = await getRestaurants(
    //                             controller.text);
    //                         setState(() {
    //                           listRestaurant.assignAll(r!);
    //                           listRestaurant.refresh();
    //                           isLoading = false;
    //                         });
    //                       }),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 12.sp),
    //                   child: InputChip(
    //                     label: Text('Bánh canh'),
    //                     onPressed: () async {
    //                       controller = new TextEditingController(
    //                           text: 'Bánh canh');
    //                       var r =
    //                       await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         )
    //             : Container(
    //           height: 834.h,
    //           child: ListView.builder(
    //               itemCount: listRestaurant.length,
    //               itemBuilder: (context, index) {
    //                 return SearchBody(
    //                   restaurant: listRestaurant[index],
    //                 );
    //               }),
    //         ),
    //       )
    //           : Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             padding: EdgeInsets.only(
    //                 left: 24.w, right: 12.w, top: 8.w, bottom: 8.w),
    //             child: Text(
    //               'Bạn đang tìm kiếm quán ăn?',
    //               style: TextStyle(fontSize: 18.sp),
    //             ),
    //           ),
    //           Wrap(
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                   label: Text('Cơm'),
    //                   onPressed: () async {
    //                     controller =
    //                     new TextEditingController(text: 'Cơm');
    //                     var r = await getRestaurants(controller.text);
    //                     setState(() {
    //                       listRestaurant.assignAll(r!);
    //                       listRestaurant.refresh();
    //                       isLoading = false;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                   label: Text('DVC Cơm sinh viên'),
    //                   onPressed: () async {
    //                     controller = new TextEditingController(
    //                         text: 'DVC Cơm sinh viên');
    //                     var r = await getRestaurants(controller.text);
    //                     setState(() {
    //                       listRestaurant.refresh();
    //                       isLoading = false;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                   label: Text('Cơm Chiên sườn'),
    //                   onPressed: () async {
    //                     controller = new TextEditingController(
    //                         text: 'Cơm Chiên sườn');
    //                     var r = await getRestaurants(controller.text);
    //                     setState(() {
    //                       listRestaurant.assignAll(r!);
    //                       listRestaurant.refresh();
    //                       isLoading = false;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                   label: Text('Bún'),
    //                   onPressed: () async {
    //                     controller =
    //                     new TextEditingController(text: 'Bún');
    //                     var r = await getRestaurants(controller.text);
    //                     setState(() {
    //                       listRestaurant.assignAll(r!);
    //                       listRestaurant.refresh();
    //                       isLoading = false;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                     label: Text('Hủ tiếu'),
    //                     onPressed: () async {
    //                       controller =
    //                       new TextEditingController(text: 'Hủ tiếu');
    //                       var r = await getRestaurants(controller.text);
    //                       setState(() {
    //                         listRestaurant.assignAll(r!);
    //                         listRestaurant.refresh();
    //                         isLoading = false;
    //                       });
    //                     }),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 12.sp),
    //                 child: InputChip(
    //                   label: Text('Bánh canh'),
    //                   onPressed: () async {
    //                     controller =
    //                     new TextEditingController(text: 'Bánh canh');
    //                     var r = await getRestaurants(controller.text);
    //                     setState(() {
    //                       listRestaurant.assignAll(r!);
    //                       listRestaurant.refresh();
    //                       isLoading = false;
    //                     });
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       isLoading
    //           ? Center(
    //         child: Container(
    //             width: 50.w,
    //             height: 50.h,
    //             color: Colors.transparent,
    //             child: const Loading()),
    //       )
    //           : Container(),
    //     ],
    //   ),
    // );
  }

  // Future<List<Restaurant>?> getRestaurants(String name) async {
  //   List<Restaurant> list;
  //   String token = (await getToken())!;
  //   Map<String, String> queryParams = {
  //     'name': name,
  //   };
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   print(queryString);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(Apis.searchRestaurantUrl + '?' + queryString),
  //       headers: <String, String>{
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $token",
  //       },
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       var parsedJson = jsonDecode(response.body);
  //       list = ListRestaurants.fromJson(parsedJson).listRestaurants!;
  //       return list;
  //     }
  //     if (response.statusCode == 204) {
  //       return new List.empty();
  //     }
  //   } on TimeoutException catch (e) {
  //     showError(e.toString());
  //   } on SocketException catch (e) {
  //     showError(e.toString());
  //   }
  //   return null;
  // }

  Future<List<ResultSearch>?> getListSearch(String name) async {
    List<ResultSearch> list;
    String token = (await getToken())!;
    Map<String, String> queryParams = {
      'name': name,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    print(queryString);
    setState(() {
      isLoading = true;
    });
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.searchUrl + '?' + queryString),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListResultSearch.fromJson(parsedJson).result!;
        return list;
      }
      if (response.statusCode == 204) {
        return new List.empty();
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}

class ResultSearch {
  int? id;
  String? name;
  String? address;
  String? image;
  String? lattitude;
  String? longtitude;
  String? rating;
  String? foodname;
  int? price;
  String? url;

  ResultSearch(
      {this.id,
      this.name,
      this.address,
      this.image,
      this.lattitude,
      this.longtitude,
      this.rating,
      this.foodname,
      this.price,
      this.url});

  ResultSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    image = json['image'];
    lattitude = json['lattitude'];
    longtitude = json['longtitude'];
    rating = json['rating'];
    foodname = json['foodname'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['lattitude'] = this.lattitude;
    data['longtitude'] = this.longtitude;
    data['rating'] = this.rating;
    data['foodname'] = this.foodname;
    data['price'] = this.price;
    data['url'] = this.url;
    return data;
  }
}

class ListResultSearch {
  List<ResultSearch>? result;

  ListResultSearch({required this.result});

  ListResultSearch.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List.generate(0, (index) => new ResultSearch());
      json['result'].forEach((v) {
        result!.add(new ResultSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
