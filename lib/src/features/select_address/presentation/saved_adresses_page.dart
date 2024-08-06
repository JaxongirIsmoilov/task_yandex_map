import 'package:flutter/material.dart';
import 'package:task_yandex_map/src/core/const/colors/app_colors.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/widgets/address_list_item.dart';

import '../data/app_location.dart';

class SavedAddressesPage extends StatelessWidget {
  const SavedAddressesPage({super.key, required this.addresses});

  final List<AppLatLong> addresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBakColor,
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (ctx, index) => AddressListItem(
          address: addresses[index],
          onDelete: () {

          },
        ),
      ),
    );
  }
}
