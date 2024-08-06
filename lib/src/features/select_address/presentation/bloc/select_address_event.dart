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
  final AppLatLong location;

  SaveLocationsEvent({required this.location, required this.context,});
}

class GettingLocationsEvent extends SelectAddressEvent {

}

class DeleteLocationEvent extends SelectAddressEvent {
  final int index;

  DeleteLocationEvent({required this.index});
}

class GetCurrentPositionEvent extends SelectAddressEvent {
  final Position current;

  GetCurrentPositionEvent({required this.current});
}
