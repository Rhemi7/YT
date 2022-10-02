import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';

class VideoTileWidget extends StatelessWidget {
  final String? title;
  final String? creator;
  final String? date;
  final String? views;
  final Item? video;

  const VideoTileWidget({
    Key? key,
     this.title,
    this.creator,
     this.date,
     this.views,
    this.video,
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(video!.snippet!.thumbnails!.medium!.url.toString()
                        // .item!
                        // .brandingSettings!
                        // .image!
                        // .bannerExternalUrl
                        // .toString()
                      // channelState.item.brandingSettings.image!.bannerExternalUrl
                    ),
                    fit: BoxFit.fitWidth)),
          ),
          // Container(
          //   width: Resolution.screenWidth(context, percent: 0.45),
          //   height: Resolution.screenHeight(context, percent: 0.14),
          //   color: Colors.greenAccent,
          // ),
          const XMargin(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    video!.snippet!.title.toString()),
                Text(
                  video!.snippet!.channelTitle.toString(),
                  style: AppTextStyle.descText.copyWith(fontSize: 11),
                ),
                Row(
                  children: [
                    Text(
                      video!.snippet!.publishTime!.toIso8601String(),
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
    );
  }
}