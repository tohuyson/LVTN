import 'package:flutter/material.dart';

class ItemProfileModel {
  String? title;
  String? description;
  Widget? page;

  ItemProfileModel({this.title, this.description, this.page});
}

// List<FunctionProfile> listFunction = [
//   // FunctionProfile(name: 'Thanh toán', widget: RestaurantsScreen()),
//   // FunctionProfile(name: 'Địa chỉ', widget: Review()),
//   // FunctionProfile(name: 'Người giao hàng', widget: OrderDelivery()),
//
//   FunctionProfile(name: 'Thanh toán', widget: null),
//   FunctionProfile(name: 'Địa chỉ', widget: null),
//   FunctionProfile(name: 'Người giao hàng', widget: null),
//   FunctionProfile(name: 'Đơn hàng của tôi', widget: null),
//   FunctionProfile(name: 'Trung tâm hỗ trợ', widget: null),
//   FunctionProfile(name: 'Chính sách và quy định', widget: null),
//   FunctionProfile(name: 'Cài đặt', widget: null),
// ];
