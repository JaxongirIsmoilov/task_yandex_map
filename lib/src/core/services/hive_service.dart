import 'package:hive_flutter/adapters.dart';

import '../../features/select_address/data/location.dart';

class HiveService {
  HiveService._();

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppLatLongAdapter());
    await Hive.openBox<AppLatLong>('addressesBox');
    // await Hive.openBox('AppBox');
  }

  static final Box<AppLatLong> latLongBox = Hive.box<AppLatLong>('addressesBox');

  static Future<void> saveAddress(List<AppLatLong> appLatLong) async {
    await latLongBox.clear();
    await latLongBox.addAll(appLatLong);
  }

  static List<AppLatLong> getSavedAddress() {
    return latLongBox.values.toList();
  }

  static Future<void> deleteAddress(int index) async {
    await latLongBox.deleteAt(index);
  }
}
