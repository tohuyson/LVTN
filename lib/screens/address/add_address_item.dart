import 'package:address_picker_vn/address_picker.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AddAddressItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddAddressItem();
  }
}

class _AddAddressItem extends State<AddAddressItem> {
  late RxList address;

  @override
  void initState() {
    address = new RxList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Chọn khi vực của bạn'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Container(
        width: 414.w,
        height: 834.h,
        color: kPrimaryColorBackground,
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                RxList a = (await getAddress())!;
                setState(() {
                  if (a != null) {
                    Get.back(result: a);
                  }
                });
              },
              child: Container(
                width: 414.w,
                height: 60.h,
                margin: EdgeInsets.only(
                    left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Text('Sử dụng vị trí hiện tại')
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              margin: EdgeInsets.only(top: 5.h),
              child: AddressPicker(
                onAddressChanged: (a) {
                  setState(() {
                    if (a.province!.isNotEmpty &&
                        a.ward!.isNotEmpty &&
                        a.district!.isNotEmpty) {
                      address.add(a.province!);
                      address.add(a.district!);
                      address.add(a.ward!);

                      Get.back(result: address);
                    }
                  });
                },
                buildItem: (text) {
                  return Text(text!,
                      style: TextStyle(color: Colors.black, fontSize: 16.sp));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<RxList?> getAddress() async {
    // List<Location> locations =  await locationFromAddress('58/3 QL1A, Linh Xuân, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam');
    // print(locations.first);
    Position position = await Geolocator.getCurrentPosition();
    print(position);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].administrativeArea!.isNotEmpty &&
          placemarks[i].subAdministrativeArea!.isNotEmpty &&
          placemarks[i].locality!.isNotEmpty) {
        print(placemarks[i]);
        address.add(placemarks[i].administrativeArea!);
        address.add(placemarks[i].subAdministrativeArea!);
        address.add(placemarks[i].locality!);
        return address;
      }
    }
  }
}
