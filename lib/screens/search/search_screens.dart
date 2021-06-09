import 'package:flutter/material.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/screens/search/components/search_begin.dart';
import 'package:fooddelivery/screens/search/components/search_body.dart';
import 'package:fooddelivery/screens/search/components/search_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
 // static TextEditingController _controller = new TextEditingController();
  String query = '';
  List<Food> foods;

  Widget buildSearch() => SearchWidget(
        text: query,
        focus: true,
        hintText: 'Tìm nhà hàng món ăn',
        onChanged: searchFood,
      );

  void searchFood(String query) {
    print(query);
    final foods = listFoodOrder.values.where((food) {
      final titleLower = food.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      print('vào');
      this.query = query;
      this.foods = foods;
       
      body = SearchBody(
        foods: foods,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    foods = List.from(listFoodOrder.values);
  }


  Widget body = SearchBegin();


  // Widget buildBody() {
  //   setState(() {
  //     _controller.text.isEmpty
  //         ? SearchBegin()
  //         : SearchBody(
  //             foods: foods,
  //           );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
      ),
      // body:
      body: body,
    );
  }
}
