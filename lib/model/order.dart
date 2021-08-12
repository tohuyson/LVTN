import 'package:fooddelivery/model/food_order.dart';
import 'package:fooddelivery/model/payment.dart';
import 'package:fooddelivery/model/status_order.dart';
import 'package:fooddelivery/model/users.dart';

import 'food.dart';

class Order {
  int? id;
  int? tax;
  int? price;
  int? priceDelivery;
  String? addressDelivery;
  String? date;
  int? orderStatusId;
  int? paymentId;
  int? discountId;
  String? note;
  int? status;
  int? userId;
  int? userDeliveryId;
  StatusOrder? statusOrder;
  List<Food>? food;
  Payment? payment;
  String? createdAt;
  String? updatedAt;
  Users? user;
  List<FoodOrder>? foodOrder;

  Order(
      {this.id,
      this.tax,
      this.price,
      this.priceDelivery,
      this.addressDelivery,
      this.date,
      this.orderStatusId,
      this.paymentId,
      this.discountId,
      this.note,
      this.status,
      this.userId,
      this.userDeliveryId,
      this.statusOrder,
      this.food,
      this.payment,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.foodOrder});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tax = json['tax'];
    price = json['price'];
    priceDelivery = json['price_delivery'];
    addressDelivery = json['address_delivery'];
    date = json['date'];
    orderStatusId = json['order_status_id'];
    paymentId = json['payment_id'];
    discountId = json['discount_id'];
    note = json['note'];
    status = json['status'];
    userId = json['user_id'];
    userDeliveryId = json['user_delivery_id'];
    statusOrder = json['status_order'] != null
        ? new StatusOrder.fromJson(json['status_order'])
        : null;
    if (json['food'] != null) {
      food = new List.generate(0, (index) => new Food());
      json['food'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    if (json['food_order'] != null) {
      foodOrder = new List.generate(0, (index) => new FoodOrder());
      json['food_order'].forEach((v) {
        foodOrder!.add(new FoodOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax'] = this.tax;
    data['price'] = this.price;
    data['price_delivery'] = this.priceDelivery;
    data['address_delivery'] = this.addressDelivery;
    data['date'] = this.date;
    data['order_status_id'] = this.orderStatusId;
    data['payment_id'] = this.paymentId;
    data['discount_id'] = this.discountId;
    data['note'] = this.note;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['user_delivery_id'] = this.userDeliveryId;
    if (this.statusOrder != null) {
      data['status_order'] = this.statusOrder!.toJson();
    }
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.foodOrder != null) {
      data['food_order'] = this.foodOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListOrders {
  List<Order>? order;

  ListOrders({this.order});

  ListOrders.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = new List.generate(0, (index) => new Order());
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderJson {
  Order? order;

  OrderJson({this.order});

  OrderJson.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}
