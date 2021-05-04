import 'package:flutter/material.dart';
import 'package:fooddelivery/components/menus.dart';
import 'package:fooddelivery/model/categories.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/store.dart';

Store store = new Store(1, "Số 1", "DHNL", Fake_Foods);

var Fake_Foods = [
  Food(
      id: 1,
      name: 'Cơm Sườn',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Cơm Gà',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Cơm Khổ Qua',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Cơm Cá khô',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Cơm Canh chưa',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Mắm tôm',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
  Food(
      id: 1,
      name: 'Cà pháo',
      image: 'Com_suon.jpg',
      rating: '4',
      numberOfRating: '10',
      price: 25000,
      slug: ''),
];
var menus = [
  Category(name: 'Cơm', url: 'rice-bowl.png'),
  Category(name: 'bún', url: 'rice-bowl.png'),
  Category(name: 'phở', url: 'rice-bowl.png'),
  Category(name: 'cháo', url: 'rice-bowl.png'),
  Category(name: 'mía', url: 'rice-bowl.png'),
  Category(name: 'coffee', url: 'rice-bowl.png'),
  Category(name: 'canh', url: 'rice-bowl.png'),
  Category(name: 'cá', url: 'rice-bowl.png'),
  Category(name: 'thịt', url: 'rice-bowl.png'),
  Category(name: 'mắm', url: 'rice-bowl.png'),
  Category(name: 'Cơm', url: 'rice-bowl.png'),
  Category(name: 'Cơm', url: 'rice-bowl.png'),
  Category(name: 'Cơm', url: 'rice-bowl.png'),
  Category(name: 'Cơm', url: 'rice-bowl.png'),
];
