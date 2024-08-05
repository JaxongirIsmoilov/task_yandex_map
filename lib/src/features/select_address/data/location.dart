import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 0)
class Location {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String name;

  Location(this.latitude, this.longitude, this.name);
}