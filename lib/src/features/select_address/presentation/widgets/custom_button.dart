import 'package:flutter/material.dart';

import '../../../../core/const/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8)
      ),
      child:  Center(
        child: Text(name, style: const TextStyle(color: AppColors.buttonTextColor, fontSize: 18),),
      ),
    );
  }
}
