import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  static DateController get to => Get.find<DateController>();
  DateTime selectedDate = DateTime.now();

  String startDates = "Chọn ngày";
  String endDates = "Chọn ngày";
  String dob = "Chọn ngày";

  selectDateDob(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)))!;
    if (picked != null && picked != selectedDate) {
      print('vo dday ah');
      print(picked);
      selectedDate = picked;
      dob = DateFormat('yyyy-MM-dd').format(picked);
      print('vo dday ah ' + selectedDate.toString());
    }
    update();
  }
}
