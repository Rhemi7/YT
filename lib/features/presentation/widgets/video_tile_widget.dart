import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/helper/date_difference.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';

class VideoTileWidget extends StatelessWidget {
  final String? title;
  final String? creator;
  final String? date;
  final String? views;
  final VideoItem? video;
  final void Function()? onTap;

  const VideoTileWidget({
    Key? key,
     this.title,
    this.creator,
     this.date,
     this.views,
    this.video,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Resolution.screenWidth(context, percent: 0.48),
              height: Resolution.screenHeight(context, percent: 0.13),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(video!.snippet!.thumbnails!.medium!.url.toString()
                      ),
                      fit: BoxFit.fitWidth)),
            ),
            const XMargin(10),
            Expanded(
              // flex: 45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      video!.snippet!.title.toString(), style: AppStyle.headingText.copyWith(fontSize: Resolution.textSize(context, 16), fontWeight: FontWeight.w400),),
                  Text(
                    video!.snippet!.channelTitle.toString(),
                    style: AppStyle.descText.copyWith(fontSize: Resolution.textSize(context, 13)),
                  ),
                  Row(
                    children: [
                      Text(
                        DateDifference.getDifference(DateTime.now(), video!.snippet!.publishTime!),
                        // video!.snippet!.publishTime!.toIso8601String(),
                        style: AppStyle.descText.copyWith(fontSize: Resolution.textSize(context, 13)),
                      ),
                      const XMargin(2),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        radius: 1,
                      ),
                      const XMargin(2),
                      Text(
                        '',
                        // video!.snippet!.channelTitle.toString(),
                        style: AppStyle.descText.copyWith(fontSize: 11),
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
      ),
    );
  }
}