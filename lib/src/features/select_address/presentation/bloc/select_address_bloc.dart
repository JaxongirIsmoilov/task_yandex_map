import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:task_yandex_map/src/core/services/hive_service.dart';
import 'package:task_yandex_map/src/features/select_address/data/app_location.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/saved_adresses_page.dart';

import '../../../../core/const/hive_box/box_consts.dart';
part 'select_address_event.dart';
part 'select_address_state.dart';

part 'select_address_bloc.freezed.dart';

class SelectAddressBloc extends Bloc<SelectAddressEvent, SelectAddressState> {
  SelectAddressBloc() : super(const SelectAddressState()) {
    on<PickingAddressEvent>(_pickingAddress);
    on<GetAddressEvent>(_getAddress);
    on<SaveLocationsEvent>(_saveLocations);
    on<GettingLocationsEvent>(_getLocations);
  }

  FutureOr<void> _pickingAddress(PickingAddressEvent event, Emitter<SelectAddressState> emit){
    emit(state.copyWith(isPicking : true));
  }

  FutureOr<void> _getAddress(GetAddressEvent event, Emitter<SelectAddressState> emit) async {
    emit(state.copyWith(isPicking : true));
    await geoCoding
        .placemarkFromCoordinates(
        event.lat, event.long)
        .then((List<geoCoding.Placemark> placemarks) {
      geoCoding.Placemark place = placemarks[0];
      emit(state.copyWith(isPicking : false, pickedAddress : "${place.subLocality}, ${place.street}"));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  FutureOr<void> _saveLocations(SaveLocationsEvent event, Emitter<SelectAddressState> emit) async{
    List<AppLatLong> lastSavedAddresses = await HiveService.getSavedAddress(BoxConsts.locations);
    Set<AppLatLong> mergedListSet = {...lastSavedAddresses, ...event.locations};
    List<AppLatLong> mergedList = mergedListSet.toList();
    await HiveService.saveAddress(mergedList).then((value){
      emit(state.copyWith(locations: mergedList));
      Navigator.of(event.context).push(MaterialPageRoute(builder: (context) => SavedAddressesPage(addresses: mergedList,)));
    });
  }

  FutureOr<void> _getLocations(GettingLocationsEvent event, Emitter<SelectAddressState> emit) async{
    var result =  await HiveService.getSavedAddress(BoxConsts.locations);
    emit(state.copyWith(locations: result));
  }
}
