import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:task_yandex_map/src/core/const/colors/app_colors.dart';
import 'package:task_yandex_map/src/core/const/consts.dart';
import 'package:task_yandex_map/src/core/const/icons/app_icons.dart';
import 'package:task_yandex_map/src/core/extensions/sized_box.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/widgets/custom_back_button.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/widgets/custom_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../data/app_location.dart';
import 'bloc/select_address_bloc.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> mapObjects = [];
  double lat = 41.311081;
  double long = 69.240562;
  late LocationData locationData;
  Location location = Location();
  String? _currentAddress;
  Position? _currentPosition;
  bool isPicking = false;
  List<AppLatLong> addresses = [];
  // ValueNotifier<bool> isPicking = ValueNotifier(false);

  @override
  void initState() {
    _initPermission();
    _moveToCameraToCurrentPosition();
    context.read<SelectAddressBloc>().add(GettingLocationsEvent());
    super.initState();
  }

  Future<void> _initPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<dynamic> _confirmSaveAddress() async{
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save address'),
        content: const Text('Addressni rostan ham saqlashni xoxlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Yo\'q'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<SelectAddressBloc>().add(SaveLocationsEvent(locations: addresses, context: context),);
            },
            child: const Text('Ha'),
          ),
        ],
      ),
    );
  }

  _moveToCameraToCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    mapObjects.add(
      PlacemarkMapObject(
        mapId: MapObjectId(_currentPosition?.heading.toString() ?? ''),
        point: Point(
            latitude: _currentPosition?.latitude ?? 41.311081,
            longitude: _currentPosition?.longitude ?? 69.240562),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          scale: 2,
          image: BitmapDescriptor.fromAssetImage('assets/icons/location.png'),
        )),
      ),
    );
    mapControllerCompleter.future.then((controller) {
      if (_currentPosition != null) {
        context.read<SelectAddressBloc>().add(GetAddressEvent(lat: _currentPosition?.latitude ?? lat, long: _currentPosition?.longitude ?? long));
      }
      controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
                latitude: _currentPosition?.latitude ?? 41.311081,
                longitude: _currentPosition?.longitude ?? 69.240562),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAddressBloc, SelectAddressState>(
      builder: (context, state) {
        isPicking = state.isPicking;
        _currentAddress =  state.pickedAddress;
        if(state.locations != null){
          addresses = state.locations;
        }
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                        20.ph,
                        Row(
                          children: [
                            20.pw,
                            Expanded(
                              child: Text(
                                isPicking
                                    ? 'Qidirilmoqda ...'
                                    : _currentAddress ?? 'Not Found',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
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
                      child: Stack(
                        children: [
                          YandexMap(
                            mapObjects: mapObjects,
                            onMapCreated: (controller) {
                              controller.moveCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target:
                                        Point(latitude: lat, longitude: long),
                                    zoom: 15,
                                  ),
                                ),
                              );
                              mapControllerCompleter.complete(controller);
                            },
                            zoomGesturesEnabled: true,
                            onCameraPositionChanged:
                                (position, reason, isFinished) {
                              context.read<SelectAddressBloc>().add(PickingAddressEvent());
                              if(isFinished){
                                context.read<SelectAddressBloc>().add(GetAddressEvent(lat: position.target.latitude, long: position.target.longitude));
                              }
                            },
                          ),
                          isPicking
                              ? Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              : const SizedBox(),
                          isPicking
                              ? Align(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppIcons.locationSvg))
                              : Align(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppIcons.profileSvg)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _moveToCameraToCurrentPosition();
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.gps_fixed),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: _confirmSaveAddress,
            child: const Padding(
                padding: EdgeInsets.all(10),
                child: CustomButton(name: 'Tasdiqlash')),
          ),
        );
      },
    );
  }
}
