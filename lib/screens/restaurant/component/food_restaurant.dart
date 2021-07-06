import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FoodRestaurant extends StatefulWidget {
  final Food? food;

  const FoodRestaurant({Key? key, this.food}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodRestaurant(
      food: food,
    );
  }
}

class _FoodRestaurant extends State<FoodRestaurant> {
  final Food? food;
  var scrollViewColtroller = new ScrollController();

  _FoodRestaurant({
    this.food,
  });

  bool? isChecked = false;
  int productCounter = 1;

  showAlert() {
    Alert(
        context: context,
        title: "Lưu ý",
        content: Container(
          width: 320.w,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              border: Border.all(color: kPrimaryColorBackground, width: 2)),
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.w),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: "Vd: không hành"),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {},
            child: Text(
              "Xác nhận",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  showPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return NotificationListener<ScrollUpdateNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollViewColtroller.position.userScrollDirection ==
                  ScrollDirection.reverse) {
                print('User is going down');
              } else {
                if (scrollViewColtroller.position.userScrollDirection ==
                    ScrollDirection.forward) {
                  print('User is going up');
                }
              }
            } as bool Function(ScrollUpdateNotification)?,
            child: Column(
              children: [
                Container(
                  height: 828.h,
                  child: NestedScrollView(
                    controller: scrollViewColtroller,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          elevation: 0,
                          expandedHeight: 200.h,
                          pinned: true,
                          leading: Container(
                            width: 30,
                            height: 30,
                            // margin: EdgeInsets.only(left: 20, top: 15.h),
                            decoration: BoxDecoration(
                              // color: Colors.black26,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              onTap: () {
                                print('back');
                                Get.back();
                              },
                              child: Icon(Icons.close),
                            ),
                          ),
                          flexibleSpace: new FlexibleSpaceBar(
                            background: Image.network(
                              'https://transviet.com.vn/images/CNDL2019/VN/BMT/Thac%20Dray%20Nur/CNDL_VN_TN_Thac%20Dray%20Nur_transviet_annapham93.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      color: Colors.white,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: kPrimaryColorBackground,
                                          width: 8))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    food!.name!,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    food!.price.toString(),
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  width: 414.w,
                                  child: Text(
                                    'Chọn Size',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                                checkWidget("Phomai", 10000),
                                checkWidget('Xúc Xích', 5000),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 414.w,
                                  padding: EdgeInsets.all(12.w),
                                  child: Text(
                                    'Lưu ý',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print('lưu ý');
                                    showAlert();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 12.w,
                                          right: 12.w,
                                          top: 16.h,
                                          bottom: 16.h),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: kPrimaryColorBackground,
                                            width: 1,
                                          ),
                                          top: BorderSide(
                                            color: kPrimaryColorBackground,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      width: 414.w,
                                      child: Text(
                                        'Vd: không hành',
                                        style: TextStyle(color: Colors.black38),
                                      )),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      print('remove');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kPrimaryColorBackground,
                                              width: 2)),
                                      child: Icon(
                                        Icons.remove,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50.w,
                                    child: Center(
                                      child: Text(
                                        '$productCounter',
                                        style: new TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('add');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColorBackground,
                                                width: 2)),
                                        child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 68.h,
                  width: 414.w,
                  color: Colors.white,
                  child: Card(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                        height: 45.h,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget checkWidget(text, price) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Container(
        padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        mystate(() {
                          isChecked = value;
                        });
                      },
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 12.w),
                child: Text(
                  '+' + price.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 10.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: kPrimaryColorBackground),
        ),
      ),
      height: 102.h,
      child: Row(
        children: [
          Image.network(
            food!.image!,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
          Container(
            width: 300.w,
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  food!.name!,
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  '10+ đã bán',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black38),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food!.price.toString() + 'đ',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        print('add');
                        showPicker();
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
