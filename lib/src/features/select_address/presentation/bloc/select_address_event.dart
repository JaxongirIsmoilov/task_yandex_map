part of 'select_address_bloc.dart';

abstract class SelectAddressEvent {}

class GetAddressEvent extends SelectAddressEvent {

  final double lat;
  final double long;

  GetAddressEvent({required this.lat, required this.long});
}

class PickingAddressEvent extends SelectAddressEvent{

}
