import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../utils/margin.dart';
import '../../utils/resolution.dart';


class PlaylistTileWidget extends StatelessWidget {
  const PlaylistTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: Resolution.screenWidth(context,
                    percent: 0.45),
                height: Resolution.screenHeight(context,
                    percent: 0.14),
                color: Colors.greenAccent,
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: Resolution.screenWidth(context,
                        percent: 0.2),
                    color: Colors.black.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("2"),
                        Icon(Icons.list_rounded)
                      ],
                    ),
                  ))
            ],
          ),
          const XMargin(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'First line First line First line First line'),
                Text(
                  'Second Line',
                  style: AppTextStyle.descText
                      .copyWith(fontSize: 11),
                ),
                Text(
                  'Third line',
                  style: AppTextStyle.descText
                      .copyWith(fontSize: 11),
                )
              ],
            ),
          ),
          // InkWell(
          //     onTap: () {},
          //     child: const Padding(
          //       padding:
          //           EdgeInsets.symmetric(horizontal: 5.0),
          //       child: Icon(
          //         Icons.share_rounded,
          //         size: 12,
          //       ),
          //     ))
        ],
      ),
    );
  }
}
