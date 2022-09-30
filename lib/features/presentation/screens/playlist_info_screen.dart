import 'package:flutter/material.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../widgets/video_tile_widget.dart';

class PlaylistInfoScreen extends StatefulWidget {
  static const routeName = "playlist_info_screen";

  const PlaylistInfoScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistInfoScreen> createState() => _PlaylistInfoScreenState();
}

class _PlaylistInfoScreenState extends State<PlaylistInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Text(
              'All Google Sessions',
              style: AppTextStyle.headingText
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Google Developers',
              style: AppTextStyle.headingText
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 14.0),
            ),
          ),
          YMargin(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
              style: AppTextStyle.descText,
            ),
          ),
          const YMargin(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("12 Videos", style: AppTextStyle.descText,),
          ),
          ListView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return const VideoTileWidget(
                title: "First line First line First line First line",
                creator: 'Second Line',
                date: "Third line 2",
                views: "Third line 3",
              );
            },
          ),
        ],
      ),
    );
  }
}
