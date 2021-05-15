import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final List <Widget> widget;
  ListWidget(this.widget);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.287,
      child: ListView(
        children: [
          for(Widget w in widget) w,
        ],
      ),
    );
  }

}