import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/provider/provider.dart';
import 'package:youtube_data_api/features/presentation/screens/play_video_screen.dart';

import '../../../utils/margin.dart';
import '../../data/model/videos_response.dart';

class SearchTile extends ConsumerWidget {
  final Item res;
  final Icon icon;
  final void Function() onTap;
  const SearchTile({
    Key? key,
    required this.res,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: icon,
          ),
          const XMargin(20),
          Expanded(
              child: Text(
            res.snippet!.title.toString(),
            style: const TextStyle(fontSize: 16),
          )),
          const XMargin(20),
          const Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}

class LocalSearchTile extends StatelessWidget {
  final Item res;
  const LocalSearchTile({
    Key? key,
    required this.res,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlayVideoScreen(videoId: res.id!.videoId.toString())));
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.history),
          ),
          const XMargin(20),
          Expanded(
              child: Text(
                res.snippet!.title.toString(),
                style: const TextStyle(fontSize: 16),
              )),
          const XMargin(20),
          const Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}

