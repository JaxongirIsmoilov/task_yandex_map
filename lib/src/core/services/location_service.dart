// import 'package:geolocator/geolocator.dart';
// import 'package:task_yandex_map/src/features/select_address/data/app_location.dart';
//
// import '../../features/select_address/domain/app_location_service.dart';
//
// class LocationService implements AppLocation {
//   final defLocation = const TashkentLocation();
//
//   @override
//   Future<bool> checkPermission() {
//     return Geolocator.checkPermission()
//         .then((value) =>
//     value == LocationPermission.always ||
//         value == LocationPermission.whileInUse)
//         .catchError((_) => false);
//   }
//
//   @override
//   Future<AppLatLong> getCurrentLocation() async {
//     return Geolocator.getCurrentPosition().then((value) {
//       return AppLatLong(lat: value.latitude, long: value.longitude);
//     }).catchError(
//           (_) => defLocation,
//     );
//   }
//
//   @override
//   Future<bool> requestPermission() {
//     return Geolocator.requestPermission()
//         .then((value) =>
//     value == LocationPermission.always ||
//         value == LocationPermission.whileInUse)
//         .catchError((_) => false);
//   }
// }