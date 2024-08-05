part of 'select_address_bloc.dart';

@freezed
class SelectAddressState with _$SelectAddressState{
  const factory SelectAddressState({
    @Default(false) bool isPicking,
    @Default('') String pickedAddress,
  }) = _Initial;
}
