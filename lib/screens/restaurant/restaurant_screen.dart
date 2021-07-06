import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:flutter/rendering.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/screens/order/order_detail.dart';
import 'package:fooddelivery/screens/order/order_detail_delivered.dart';
import 'package:fooddelivery/screens/restaurant/component/food_restaurant.dart';
import 'package:fooddelivery/screens/search/components/search_widget.dart';
import 'package:get/get.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantsScreen();
  }
}

class _RestaurantsScreen extends State<RestaurantsScreen> {
  static var scrollViewColtroller = new ScrollController();

  Widget iconSearch() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.zero,
      child: IconButton(
        onPressed: () {
          print('search');
        },
        icon: Icon(
          Icons.search,
          size: 30.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget? title;

  @override
  void initState() {
    super.initState();
    title = iconSearch();
  }

  String query = '';

  Widget buildSearch() => SearchWidget(
        text: query,
        focus: false,
        hintText: 'Tìm nhà hàng món ăn',
        onChanged: searchFood,
      );

  void searchFood(String query) {
    print(query);
    final foods = listFoodOrder.values.where((food) {
      final titleLower = food.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      print('vào');
      this.query = query;
      // this.foods = foods;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NotificationListener<ScrollUpdateNotification>(
          // ignore: missing_return
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollViewColtroller.position.userScrollDirection ==
                ScrollDirection.reverse) {
              print('User is going down');
              setState(() {
                title = buildSearch();
              });
            } else {
              if (scrollViewColtroller.position.userScrollDirection ==
                  ScrollDirection.forward) {
                print('User is going up');
                setState(() {
                  title = iconSearch();
                });
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
                        expandedHeight: 220.h,
                        pinned: true,
                        title: title,
                        flexibleSpace: new FlexibleSpaceBar(
                          background: Image.network(
                            'https://transviet.com.vn/images/CNDL2019/VN/BMT/Thac%20Dray%20Nur/CNDL_VN_TN_Thac%20Dray%20Nur_transviet_annapham93.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: IconButton(
                              onPressed: () {
                                print('...');
                              },
                              icon: Icon(
                                Icons.keyboard_control,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SliverAppBar(
                        expandedHeight: 80.h,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        flexibleSpace: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 8.w,
                                      color: kPrimaryColorBackground))),
                          width: 414.w,
                          // height: 104.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 414.w,
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text(
                                  restaurant.name!,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 22.sp,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.w),
                                      child: Text(
                                        '4.7 (500+)',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text(
                                        '-',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    Text(
                                      '2.5km',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverAppBar(
                        pinned: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        toolbarHeight: 20,
                        flexibleSpace: Container(
                          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                          child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Container(
                                  width: 60.w,
                                  child: Text(
                                    'Đặt đơn',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 70.w,
                                  child: Text(
                                    'Bình luận',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 90.w,
                                  child: Text(
                                    'Khuyến mãi',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 70.w,
                                  child: Text(
                                    'Thông tin',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      ListView(
                        children: [
                          for (Food food in restaurant.listFood!)
                            FoodRestaurant(
                              food: food,
                            )
                        ],
                      ),
                      Text('2'),
                      Text('3'),
                      Text('4'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 68.h,
                width: 414.w,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    print('Đặt hàng');
                    Get.to(OrderDetail());
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                    height: 45.h,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: Text(
                            '1 món',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                        Text(
                          'Đặt hàng',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Text(
                            '10000đ',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
