import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/utils/margin.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/model/playlist_videos_response.dart';
import '../notifier/get_playlist_videos/get_playlist_videos_state.dart';
import '../provider/provider.dart';
import '../widgets/playlist_video_tile_widget.dart';

class VideoPlaylistScreen extends ConsumerStatefulWidget {
  final String? id;
  final Item? item;
  const VideoPlaylistScreen({Key? key, this.id, this.item}) : super(key: key);

  @override
  ConsumerState<VideoPlaylistScreen> createState() =>
      _VideoPlaylistScreenState();
}

class _VideoPlaylistScreenState extends ConsumerState<VideoPlaylistScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.id.toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(getPlaylistVideosNotifierProvider.notifier)
          .getVideosInPlaylist(widget.item!.snippet!.playlistId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          YMargin(10),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(getPlaylistVideosNotifierProvider);
            if (state is GetPlaylistVideosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPlaylistVideosLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.items!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PlaylistVideoTileWidget(
                      video: state.items![index],
                      id: widget.id,
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
