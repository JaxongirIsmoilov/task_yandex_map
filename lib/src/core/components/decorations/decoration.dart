import 'package:flutter/material.dart';

Decoration commonDeco({Color? c, double? r, required BuildContext ctx,bool? withSh}){
  return BoxDecoration(
      borderRadius: BorderRadius.circular(r ?? 8),
      color: c ?? Colors.white,
      boxShadow: withSh ?? true ? shadow(ctx: ctx) : null
  );
}

List<BoxShadow>? shadow({required BuildContext ctx, double? rad}){
  return  [
    BoxShadow(
      // color: ctx.color!.secondary.withOpacity(0.05),
      spreadRadius: rad ?? 8,
      blurRadius: 8,
      offset: const Offset(0, 0), // changes position of shadow
    ),
  ];
}