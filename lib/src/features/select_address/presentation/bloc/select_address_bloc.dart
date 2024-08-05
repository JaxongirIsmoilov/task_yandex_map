import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
part 'select_address_event.dart';
part 'select_address_state.dart';

part 'select_address_bloc.freezed.dart';

class SelectAddressBloc extends Bloc<SelectAddressEvent, SelectAddressState> {
  SelectAddressBloc() : super(const SelectAddressState()) {
    on<PickingAddressEvent>(_pickingAddress);
    on<GetAddressEvent>(_getAddress);
  }

  FutureOr<void> _pickingAddress(PickingAddressEvent event, Emitter<SelectAddressState> emit){
    emit(state.copyWith(isPicking : true));
  }

  Future<FutureOr<void>> _getAddress(GetAddressEvent event, Emitter<SelectAddressState> emit) async {
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
}
