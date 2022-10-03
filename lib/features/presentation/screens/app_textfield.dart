import 'package:flutter/material.dart';
class AppTextfield extends StatelessWidget {
  const AppTextfield({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          // border: InputBorder.none,
            fillColor: const Color(0xff4D4D4D),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xff4D4D4D),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xff4D4D4D),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 10.0),
            isDense: true),
      ),
    );
  }
}