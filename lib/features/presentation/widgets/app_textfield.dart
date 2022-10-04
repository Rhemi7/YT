import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield({
    Key? key,
    required this.searchController,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController searchController;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        autofocus: true,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            isDense: true),
      ),
    );
  }
}
