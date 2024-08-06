import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_yandex_map/src/core/const/colors/app_colors.dart';
import 'package:task_yandex_map/src/core/const/icons/app_icons.dart';
import 'package:task_yandex_map/src/core/extensions/sized_box.dart';
import 'package:task_yandex_map/src/features/select_address/presentation/bloc/select_address_bloc.dart';

import '../data/location.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  @override
  void initState() {
    context.read<SelectAddressBloc>().add(GettingLocationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AppLatLong> addresses = [];
    return BlocBuilder<SelectAddressBloc, SelectAddressState>(
      builder: (context, state) {
        addresses = state.locations;
        print("qwertyuio${state.locations.length}");
        return Scaffold(
          backgroundColor: AppColors.appBakColor,
          body: addresses.isEmpty
              ? Center(
                  child: Text('Saqlangan address topilmadi'),
                )
              : Column(
                  children: [
                    10.ph,
                    Expanded(
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (ctx, index) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Text(addresses[index].name),
                            trailing: GestureDetector(
                              onTap: () {
                                context
                                    .read<SelectAddressBloc>()
                                    .add(DeleteLocationEvent(index: index));
                              },
                              child: SvgPicture.asset(AppIcons.trashSvg),
                            ),
                            tileColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
