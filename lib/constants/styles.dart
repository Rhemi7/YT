

import 'dart:ui';
import 'package:flutter/material.dart';

class AppStyle {


  static final descText = TextStyle(fontSize: 13, color: Colors.grey.shade400);

  static const headingText =  TextStyle(
  fontWeight: FontWeight.w700, fontSize: 17);

  static const modalBottomSheetCurve = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10),
      topLeft: Radius.circular(10),
    ),
  );


}