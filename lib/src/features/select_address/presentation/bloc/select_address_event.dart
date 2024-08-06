part of 'select_address_bloc.dart';

abstract class SelectAddressEvent {}

class GetAddressEvent extends SelectAddressEvent {

  final double lat;
  final double long;

  GetAddressEvent({required this.lat, required this.long});
}

class PickingAddressEvent extends SelectAddressEvent{

}

class SaveLocationsEvent extends SelectAddressEvent {
  final BuildContext context;
  final List<AppLatLong> locations;

  SaveLocationsEvent({required this.locations, required this.context,});
}

class GettingLocationsEvent extends SelectAddressEvent {

}

