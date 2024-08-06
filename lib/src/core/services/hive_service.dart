import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_yandex_map/src/core/const/consts.dart';
import 'package:task_yandex_map/src/features/select_address/data/app_location.dart';

import '../../features/select_address/data/location.dart';
import '../const/hive_box/box_consts.dart';

class HiveService {
  HiveService._();
  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('AppBox');
  }

  static final box = Hive.box('AppBox');

  static Future<void> saveAddress(List<AppLatLong> appLatLong) async{
    box.put(BoxConsts.locations,appLatLong);
  }

  static Future<List<AppLatLong>> getSavedAddress(String name){
    return box.get(BoxConsts.locations);
  }


}