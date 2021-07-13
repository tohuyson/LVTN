import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;
  int index = 0;

  final List<Tab> myTabs = <Tab>[
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
  ];

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this, initialIndex: index);
    super.onInit();
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }
}
