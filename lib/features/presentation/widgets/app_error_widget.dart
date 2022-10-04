import 'package:flutter/material.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key, required this.error, required this.onTap})
      : super(key: key);

  final String error;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        YMargin(Resolution.screenHeight(context, percent: 0.3)),
        Center(
            child: Text(
          error,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )),
        const YMargin(20),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            width: 100,
            color: Colors.red,
            child: const Center(
                child: Text(
              'Retry',
              style: TextStyle(fontSize: 18),
            )),
          ),
        )
      ],
    );
  }
}
