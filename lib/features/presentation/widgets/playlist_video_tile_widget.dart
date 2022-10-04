import 'package:flutter/material.dart';
import 'package:youtube_data_api/helper/date_difference.dart';
import 'package:youtube_data_api/helper/string_extension.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/playlist_videos_response.dart';

class PlaylistVideoTileWidget extends StatelessWidget {
  final Item? video;
  final String? id;
  final void Function()? onTap;

  const PlaylistVideoTileWidget({
    Key? key,
    this.video,
    this.id,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: id == video!.snippet!.resourceId!.videoId
            ? Colors.brown.shade600
            : Colors.brown.shade600.withOpacity(0),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const XMargin(10),
            Container(
              width: Resolution.screenWidth(context, percent: 0.48),
              height: Resolution.screenHeight(context, percent: 0.13),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          video!.snippet!.thumbnails!.medium!.url.toString()),
                      fit: BoxFit.fitWidth)),
            ),
            const XMargin(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video!.snippet!.title.toString().truncateTo(50),
                      style: AppStyle.headingText.copyWith(
                          fontSize: Resolution.textSize(context, 16),
                          fontWeight: FontWeight.w400)),
                  Text(
                    video!.snippet!.channelTitle.toString(),
                    style: AppStyle.descText
                        .copyWith(fontSize: Resolution.textSize(context, 13)),
                  ),
                  Row(
                    children: [
                      Text(
                        DateDifference.getDifference(
                            DateTime.now(), video!.snippet!.publishedAt!),
                        style: AppStyle.descText.copyWith(
                            fontSize: Resolution.textSize(context, 13)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
