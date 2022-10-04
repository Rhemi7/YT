import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';
import 'package:youtube_data_api/features/presentation/screens/playlist_info_screen.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';

class PlaylistTileWidget extends StatelessWidget {
  final PlaylistItem playlist;
  const PlaylistTileWidget({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlaylistInfoScreen(playlistItem: playlist)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: Resolution.screenWidth(context, percent: 0.5),
                  height: Resolution.screenHeight(context, percent: 0.13),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(playlist
                              .snippet!.thumbnails!.medium!.url
                              .toString()),
                          fit: BoxFit.fitWidth)),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: Resolution.screenWidth(context, percent: 0.2),
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(playlist.contentDetails!.itemCount.toString()),
                          const Icon(Icons.list_rounded)
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
                  Text(
                    playlist.snippet!.title!.toString(),
                    style: AppStyle.headingText.copyWith(
                        fontSize: Resolution.textSize(context, 16),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    playlist.snippet!.channelTitle!.toString(),
                    style: AppStyle.descText
                        .copyWith(fontSize: Resolution.textSize(context, 13)),
                  ),
                  Text(
                    "${playlist.contentDetails!.itemCount} videos",
                    style: AppStyle.descText
                        .copyWith(fontSize: Resolution.textSize(context, 13)),
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
