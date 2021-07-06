import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/screens/order/order_coming.dart';
import 'package:fooddelivery/screens/order/order_item.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderScreen();
  }
}

class _OrderScreen extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    print(index);
    _tabController = TabController(length: 3, vsync: this, initialIndex: index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
                height: 50.h,
                color: Colors.white,
                padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                child: TabBar(
                  labelColor: Colors.black,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Center(
                        child: Text(
                          'Đang đến',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Lịch sử',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Đơn nháp',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    order_1.status == false
                        ? OrderComing(
                            order: order_1,
                          )
                        : Text('Không có đơn hàng'),
                    listOrder.isNotEmpty
                        ? OrderItem(
                            listOrder: listOrder,
                          )
                        : Text('Không có đơn hàng'),
                    Container(height: 100, child: Text('piuhhj')),
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
