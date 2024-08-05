import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../features/select_address/data/location.dart';

class HiveService {
  HiveService._();
  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('AppBox');
  }

  static final box = Hive.box<List<Location>>('AppBox');

}