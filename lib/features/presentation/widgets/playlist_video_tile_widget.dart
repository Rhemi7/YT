import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/presentation/screens/video_playlist_screen.dart';

import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/playlist_videos_response.dart';

class PlaylistVideoTileWidget extends StatelessWidget {
  final Item? video;

  const PlaylistVideoTileWidget({
    Key? key,
    this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlaylistScreen(
                        id: video!.snippet!.resourceId!.videoId,
                      )));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Resolution.screenWidth(context, percent: 0.45),
              height: Resolution.screenHeight(context, percent: 0.14),
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
                  Text(video!.snippet!.title.toString()),
                  Text(
                    video!.snippet!.channelTitle.toString(),
                    style: AppTextStyle.descText.copyWith(fontSize: 11),
                  ),
                  Row(
                    children: [
                      Text(
                        video!.snippet!.publishedAt!.toIso8601String(),
                        style: AppTextStyle.descText.copyWith(fontSize: 11),
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
      ),
    );
  }
}
