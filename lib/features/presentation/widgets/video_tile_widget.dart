import 'package:flutter/material.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';

class VideoTileWidget extends StatelessWidget {
  final String title;
  final String creator;
  final String date;
  final String views;

  const VideoTileWidget({
    Key? key,
    required this.title,
    required this.creator,
    required this.date,
    required this.views
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Resolution.screenWidth(context, percent: 0.45),
            height: Resolution.screenHeight(context, percent: 0.14),
            color: Colors.greenAccent,
          ),
          const XMargin(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title),
                Text(
                  'Second Line',
                  style: AppTextStyle.descText.copyWith(fontSize: 11),
                ),
                Row(
                  children: [
                    Text(
                      'Third line 1',
                      style: AppTextStyle.descText.copyWith(fontSize: 11),
                    ),
                    const XMargin(2),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 1,
                    ),
                    const XMargin(2),
                    Text(
                      'Third line 2',
                      style: AppTextStyle.descText.copyWith(fontSize: 11),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Icons.share_rounded,
                  size: 12,
                ),
              ))
        ],
      ),
    );
  }
}