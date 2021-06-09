import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FoodRestaurant extends StatefulWidget {
  final Food food;

  const FoodRestaurant({Key key, this.food}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodRestaurant(
      food: food,
    );
  }
}

class _FoodRestaurant extends State<FoodRestaurant> {
  final Food food;
  var scrollViewColtroller = new ScrollController();

  _FoodRestaurant({
    this.food,
  });

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
            },
            child: Container(
              color: Colors.white,
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
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 8, color: kPrimaryColorBackground),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                                width: 280.w,
                                child: Text(
                                  food.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                                width: 106.w,
                                child: Text(
                                  food.price.toString(),
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            width: 414.w,
                            child: Text(
                              'Mô tả',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.sp,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          );
        });
  }
  bool isChecked = false;
  Widget checkWidget(text, price) {
    return Container(
      child: Row(
        children: [
          Checkbox(value: isChecked, onChanged: (bool value) {
            setState(() {
              isChecked = value;
            });
          },)
        ],
      ),
    );
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
            food.image,
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
                  food.name,
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
                      food.price.toString() + 'đ',
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
