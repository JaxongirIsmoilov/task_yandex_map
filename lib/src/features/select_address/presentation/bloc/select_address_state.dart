part of 'select_address_bloc.dart';

@freezed
class SelectAddressState with _$SelectAddressState {
  const factory SelectAddressState({
    @Default(false) bool isPicking,
    @Default('') String pickedAddress,
    @Default([]) List<AppLatLong> locations,
    Position? currentPosition,
  }) = _Initial;

  factory SelectAddressState.initial() {
    return SelectAddressState(
      currentPosition: Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(), // or another default DateTime value
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
    );
  }
}
