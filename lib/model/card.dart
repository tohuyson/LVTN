import 'package:fooddelivery/model/restaurant.dart';

import 'card_oder.dart';

class ListCardModel {
  List<CardModel>? card;

  ListCardModel({required this.card});

  ListCardModel.fromJson(Map<String, dynamic> json) {
    if (json['card'] != null) {
      card = new List.generate(0, (index) => new CardModel());
      json['card'].forEach((v) {
        card!.add(new CardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardModel {
  int? id;
  int? userId;
  int? sumPrice;
  int? restaurantId;
  List<CardOrder>? cardOrder;
  Restaurant? restaurant;

  CardModel(
      {this.id, this.userId, this.sumPrice, this.restaurantId, this.cardOrder, this.restaurant});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sumPrice = json['sum_price'];
    restaurantId = json['restaurant_id'];
    if (json['card_order'] != null) {
      cardOrder = new List.generate(0, (index) => new CardOrder());
      json['card_order'].forEach((v) {
        cardOrder!.add(new CardOrder.fromJson(v));
      });
    }
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sum_price'] = this.sumPrice;
    data['restaurant_id'] = this.restaurantId;
    if (this.cardOrder != null) {
      data['card_order'] = this.cardOrder!.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    return data;
  }
}

class CardJson {
  CardModel? card;

  CardJson({this.card});

  CardJson.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? new CardModel.fromJson(json['card']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    return data;
  }
}
