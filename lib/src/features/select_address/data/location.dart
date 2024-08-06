import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 0)
class AppLatLong {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String name;

  AppLatLong(this.latitude, this.longitude, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppLatLong &&
              runtimeType == other.runtimeType &&
              latitude == other.latitude &&
              longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}