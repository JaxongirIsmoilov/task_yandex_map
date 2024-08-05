import 'package:hive/hive.dart';

import '../../features/select_address/data/location.dart';
import '../const/hive_box/box_consts.dart';

class HiveService {
  HiveService._();
  static Future<void> initHive() async {
    await Hive.openBox('AppBox');
  }

  static final box = Hive.box<List<Location>>('AppBox');

}