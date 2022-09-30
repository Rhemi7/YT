import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {

  final double width;

  const XMargin(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class YMargin extends StatelessWidget {

  final double height;

  const YMargin(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}