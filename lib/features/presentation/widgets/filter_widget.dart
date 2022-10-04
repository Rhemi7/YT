import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? buttonColor;
  const FilterWidget({
    Key? key,
    required this.text,
    this.buttonColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(text)),
      ),
    );
  }
}
