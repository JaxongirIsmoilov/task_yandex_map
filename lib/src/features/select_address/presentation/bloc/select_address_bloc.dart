import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:task_yandex_map/src/core/services/hive_service.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/saved_adresses_page.dart';

import '../../data/location.dart';

part 'select_address_bloc.freezed.dart';
part 'select_address_event.dart';
part 'select_address_state.dart';

class SelectAddressBloc extends Bloc<SelectAddressEvent, SelectAddressState> {
  SelectAddressBloc() : super(const SelectAddressState()) {
    on<PickingAddressEvent>(_pickingAddress);
    on<GetAddressEvent>(_getAddress);
    on<SaveLocationsEvent>(_saveLocations);
    on<GettingLocationsEvent>(_getLocations);
    on<DeleteLocationEvent>(_deleteLocation);
    on<GetCurrentPositionEvent>(_getCurrentLocation);
  }

  FutureOr<void> _getCurrentLocation(GetCurrentPositionEvent event, Emitter<SelectAddressState> emit){
    emit(state.copyWith(currentPosition: event.current));
  }

  FutureOr<void> _deleteLocation(
      DeleteLocationEvent event, Emitter<SelectAddressState> emit) {
    HiveService.deleteAddress(event.index);
    var result = HiveService.getSavedAddress();
    emit(state.copyWith(locations: result));
  }

  FutureOr<void> _pickingAddress(
      PickingAddressEvent event, Emitter<SelectAddressState> emit) {
    emit(state.copyWith(isPicking: true));
  }

  FutureOr<void> _getAddress(
      GetAddressEvent event, Emitter<SelectAddressState> emit) async {
    emit(state.copyWith(isPicking: true));
    await geoCoding
        .placemarkFromCoordinates(event.lat, event.long)
        .then((List<geoCoding.Placemark> placemarks) {
      geoCoding.Placemark place = placemarks[0];
      emit(state.copyWith(
          isPicking: false,
          pickedAddress: "${place.subLocality}, ${place.street}"));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  FutureOr<void> _saveLocations(
      SaveLocationsEvent event, Emitter<SelectAddressState> emit) async {
    List<AppLatLong> lastSavedAddresses = HiveService.getSavedAddress();
    lastSavedAddresses.add(event.location);
    print(lastSavedAddresses.length);
    await HiveService.saveAddress(lastSavedAddresses).then((value) {
      emit(state.copyWith(locations: lastSavedAddresses));
      Navigator.of(event.context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SelectAddressBloc(),
            child: const SavedAddressesPage(),
          ),
        ),
      );
    });
  }

  FutureOr<void> _getLocations(
      GettingLocationsEvent event, Emitter<SelectAddressState> emit) async {
    var result = HiveService.getSavedAddress();
    emit(state.copyWith(locations: result));
  }
}
