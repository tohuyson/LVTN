import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/screens/order/draft_order.dart';
import 'package:fooddelivery/screens/order/order_coming.dart';
import 'package:fooddelivery/screens/order/order_item.dart';
import 'package:get/get.dart';

import 'history_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderScreen();
  }
}

class _OrderScreen extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TabController? tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Center(
        child: Text(
          'Đang đến',
        ),
      ),
    ),
    Tab(
      child: Center(
        child: Text(
          'Lịch sử',
        ),
      ),
    ),
    Tab(
      child: Center(
        child: Text(
          'Đơn nháp',
        ),
      ),
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Đơn hàng',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: kPrimaryColorBackground,
          width: double.infinity,
          height: 834.h,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                // constraints: BoxConstraints.expand(height: 50.h),
                child: TabBar(
                  unselectedLabelColor: Colors.black87,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  controller: tabController,
                  tabs: myTabs,
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    OrderComing(
                        // order: order_1,
                        ),
                    HistoryScreen(),
                    // order_1.status == false
                    //     ? OrderComing(
                    //         order: order_1,
                    //       )
                    //     : Text('Không có đơn hàng'),
                    // listOrder.isNotEmpty
                    //     ? OrderItem(
                    //         listOrder: listOrder,
                    //       )
                    //     : Text('Không có đơn hàng'),
                    DraftOrder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
