import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:fooddelivery/model/slider.dart';

class SlideBannerWidget extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.listSliders.length > 0
          ? ImageSlideshow(
              width: double.infinity,
              height: 140.h,
              initialPage: 0,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorBackgroundColor: Colors.white,
              children: [
                // controller.listSliders.forEach((element) { })
                for (Sliders slider in controller.sliders)
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
}
