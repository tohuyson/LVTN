import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/apis.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/model/list_sliders.dart';
import 'package:fooddelivery/utils.dart';
import 'package:get/get.dart';
import 'package:fooddelivery/model/slider.dart';
import 'package:http/http.dart' as http;

class SlideBannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideBannerWidget();
  }
}

class _SlideBannerWidget extends State<SlideBannerWidget> {
  late RxList<Sliders> sliders;

  @override
  void initState() {
    sliders = new RxList<Sliders>();
    fetchSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => sliders.length > 0
          ? ImageSlideshow(
              width: double.infinity,
              height: 140.h,
              initialPage: 0,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorBackgroundColor: Colors.white,
              children: [
                // controller.listSliders.forEach((element) { })
                for (Sliders slider in sliders)
                  Image.network(
                    slider.url!,
                    fit: BoxFit.fill,
                  ),
              ],
              onPageChanged: (value) {
                // print('Page changed: $value');
              },
              autoPlayInterval: 3000,
            )
          : Container(),
    );
  }

  void fetchSliders() async {
    var s = await getSliders();
    if (s != null) {
      sliders.assignAll(s);
      sliders.refresh();
    }
  }

  Future<List<Sliders>?> getSliders() async {
    List<Sliders> list;
    String token = (await getToken())!;
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getSlidersUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        list = ListSliders.fromJson(parsedJson).listSliders!;
        return list;
      }
      if (response.statusCode == 401) {
        showToast("Load failed");
      }
      if (response.statusCode == 500) {
        showToast("Server error, please try again later!");
      }
    } on TimeoutException catch (e) {
      showError(e.toString());
    } on SocketException catch (e) {
      showError(e.toString());
    }
    return null;
  }
}
