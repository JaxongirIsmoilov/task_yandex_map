import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget withAlign(AlignmentGeometry alignment) => Align(
    alignment: alignment,
    child: this,
  );

  Widget paddingOnly({double l = 0, double r = 0, double t = 0, double b = 0}) {
    return Padding(
      padding: EdgeInsets.only(
        left: l,
        right: r,
        top: t,
        bottom: b,
      ),
      child: this,
    );
  }

  Widget paddingSymmetric({
    double v = 0,
    double h = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: v,
        horizontal: h,
      ),
      child: this,
    );
  }

  Widget paddingLTRB(double l, double t, double r, double b) => Padding(
    padding: EdgeInsets.fromLTRB(l, t, r, b),
    child: this,
  );

  Widget paddingAll(double padding) => Padding(
    padding: EdgeInsets.all(padding),
    child: this,
  );

  Widget withGesture(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: this,
  );
  Widget withInkWell(VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: this,
  );

  Widget expandedHorizontally() {
    return Row(
      children: [
        Expanded(child: this),
      ],
    );
  }

  Widget withConstraints({
    double maxHeight = double.infinity,
    double minHeight = 0.0,
    double minWidth = 0.0,
    double maxWidth = double.infinity,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
        maxWidth: maxWidth,
        minWidth: minWidth,
      ),
      child: this,
    );
  }
}
