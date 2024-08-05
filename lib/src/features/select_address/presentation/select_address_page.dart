import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_picker/map_picker.dart';
import 'package:task_yandex_map/src/core/const/colors/app_colors.dart';
import 'package:task_yandex_map/src/core/const/consts.dart';
import 'package:task_yandex_map/src/core/const/icons/app_icons.dart';
import 'package:task_yandex_map/src/core/extensions/sized_box.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/widgets/custom_back_button.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/widgets/custom_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/services/location_service.dart';
import '../data/app_location.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final mapPickerController = MapPickerController();
  final List<MapObject> mapObject = [];
  double lat = 41.311081;
  double long = 69.240562;

  @override
  void initState() {
    super.initState();
    // _initPermission().ignore();
  }

  // Future<void> _initPermission() async {
  //   if (!await LocationService().checkPermission()) {
  //     await LocationService().requestPermission();
  //   }
  //   await _fetchCurrentLocation();
  // }
  //
  // Future<void> _fetchCurrentLocation() async {
  //   AppLatLong location;
  //   const defLocation = TashkentLocation();
  //   try {
  //     location = await LocationService().getCurrentLocation();
  //   } catch (_) {
  //     location = defLocation;
  //   }
  //   _moveToCurrentLocation(location);
  // }
  //
  // Future<void> _moveToCurrentLocation(
  //     AppLatLong appLatLong,
  //     ) async {
  //   (await mapControllerCompleter.future).moveCamera(
  //     animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: Point(
  //           latitude: appLatLong.lat,
  //           longitude: appLatLong.long,
  //         ),
  //         zoom: 12,
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBakColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ///
                    },
                    child: const CustomBackButton(),
                  ),
                  // const Spacer(),
                ],
              ),
              1.ph,
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConsts.borderRadius),
                  ),
                ),
                child: Column(
                  children: [
                    20.ph,
                    Row(
                      children: [
                        20.pw,
                        const Text(
                          'Ketish manzili',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    20.ph,
                    Row(
                      children: [
                        20.pw,
                        const Text(
                          'Toshkent, Amir Temur, 7',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    10.ph,
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppConsts.borderRadius),
                    bottomRight: Radius.circular(AppConsts.borderRadius),
                  ),
                  child: MapPicker(
                    mapPickerController: mapPickerController,
                    iconWidget: SvgPicture.asset(AppIcons.locationSvg),
                    child: YandexMap(
                      onMapCreated: (controller) {
                        controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: Point(latitude: lat, longitude: long),
                                zoom: 15),
                          ),
                        );
                        mapControllerCompleter.complete(controller);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        // _moveToCurrentLocation(AppLatLong(lat: lat, long: long));
      }, backgroundColor: Colors.white, child: const Icon(Icons.gps_fixed),),
      bottomNavigationBar: GestureDetector(
        onTap: () {},
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: CustomButton(name: 'Tasdiqlash')),
      ),
    );
  }
}
