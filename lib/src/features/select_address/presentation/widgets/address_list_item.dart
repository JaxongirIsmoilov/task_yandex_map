import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_yandex_map/src/core/const/icons/app_icons.dart';
import 'package:task_yandex_map/src/core/extensions/sized_box.dart';
import 'package:task_yandex_map/src/core/extensions/widget_ext.dart';
import 'package:task_yandex_map/src/features/select_address/data/app_location.dart';

import '../../../../core/components/decorations/decoration.dart';


class AddressListItem extends StatelessWidget {
  const AddressListItem({super.key, required this.address, required this.onDelete,});
  final AppLatLong address;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: commonDeco(ctx: context, withSh: false),
      child: Row(
        children: [
          Container(decoration: commonDeco(
              ctx: context,
              r: 8,
              ), child: Text(address.name, style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),),
          ),
          5.pw,
          Expanded(
            child: Text(address.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: commonDeco(
                  ctx: context,
                  r: 5,
              ),
              child: SvgPicture.asset(AppIcons.trashSvg),
            ),
          ),
          10.pw,
        ],
      ).paddingSymmetric(v: 4, h: 12),
    ).paddingOnly(l: 16, r: 16, t: 4);
  }
}
