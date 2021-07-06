import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:fooddelivery/model/data_fake.dart';
import 'package:fooddelivery/model/slide_banner.dart';
import 'package:fooddelivery/model/sliders.dart';
import 'package:get/get.dart';

class SlideBannerWidget extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ImageSlideshow(
        width: double.infinity,
        height: 140.h,
        initialPage: 0,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorBackgroundColor: Colors.white,
        children: [
          for (Sliders slider in controller.listSliders)
            Image.network(
              slider.url!,
              fit: BoxFit.fill,
            ),
        ],
        onPageChanged: (value) {
          // print('Page changed: $value');
        },
        autoPlayInterval: 3000,
      ),
    );
  }
}
