import 'package:flutter/material.dart';
import 'package:task_yandex_map/src/core/const/consts.dart';
import 'package:task_yandex_map/src/core/extensions/sized_box.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(AppConsts.borderRadius), topRight: Radius.circular(AppConsts.borderRadius),)
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.arrow_back),
          4.pw,
          const Text('Ortga qaytish', style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}
