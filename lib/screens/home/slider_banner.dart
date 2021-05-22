import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/model/slide_banner.dart';

class SlideBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SlideBanner> banners = [
      SlideBanner(
          url:
              'https://images.foody.vn/delivery/collection/s320x200/image-58937a8c-210511003253.jpeg'),
      SlideBanner(
          url:
              'https://images.foody.vn/delivery/collection/s320x200/image-29242f79-210519152743.jpeg'),
      SlideBanner(
          url:
              'https://images.foody.vn/delivery/collection/s320x200/image-3c72a92f-210507112418.jpeg')
    ];
    return Container(
      padding: EdgeInsets.only(top: 1.h),
      child: ImageSlideshow(
        width: double.infinity,
        height: 130.h,
        initialPage: 0,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorBackgroundColor: Colors.white,
        children: [
          for (SlideBanner b in banners)
            Image.network(
              b.url,
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
