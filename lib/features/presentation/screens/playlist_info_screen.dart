import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist_videos/get_playlist_videos_state.dart';
import 'package:youtube_data_api/features/presentation/screens/video_playlist_screen.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/playlist_response.dart';
import '../provider/provider.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/playlist_video_tile_widget.dart';

class PlaylistInfoScreen extends ConsumerStatefulWidget {
  static const routeName = "playlist_info_screen";
  final PlaylistItem playlistItem;

  const PlaylistInfoScreen({Key? key, required this.playlistItem})
      : super(key: key);

  @override
  ConsumerState<PlaylistInfoScreen> createState() => _PlaylistInfoScreenState();
}

class _PlaylistInfoScreenState extends ConsumerState<PlaylistInfoScreen> {
  ScrollController playlistVidController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(getPlaylistVideosNotifierProvider.notifier)
          .getVideosInPlaylist(widget.playlistItem.id.toString());
    });
    playlistVidController.addListener(() {
      if (playlistVidController.position.pixels ==
          playlistVidController.position.maxScrollExtent) {
        ref
            .watch(getPlaylistVideosNotifierProvider.notifier)
            .getNextVideosInPlaylist(
                playlistId: widget.playlistItem.id.toString());
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xff212121),

      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(getPlaylistVideosNotifierProvider);
        if (state is GetPlaylistVideosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetPlaylistVideosLoaded) {
          return ListView(
            controller: playlistVidController,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.playlistItem.snippet!.title!.toString(),
                  style: AppStyle.headingText.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Resolution.textSize(context, 22)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.playlistItem.snippet!.channelTitle.toString(),
                  style: AppStyle.headingText.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Resolution.textSize(context, 17)),
                ),
              ),
              const YMargin(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.playlistItem.snippet!.description.toString(),
                  style: AppStyle.descText
                      .copyWith(fontSize: Resolution.textSize(context, 16)),
                ),
              ),
              const YMargin(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "${widget.playlistItem.contentDetails!.itemCount} Videos",
                  style:
                      AppStyle.descText.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              ListView.builder(
                itemCount: state.items!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.items!.length - 1) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(child: CircularProgressIndicator())),
                    );
                  }
                  return PlaylistVideoTileWidget(
                    video: state.items![index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoPlaylistScreen(
                                    item: state.items![index],
                                  )));
                    },
                  );
                },
              ),
            ],
          );
        } else if (state is GetPlaylistVideosError) {
          return AppErrorWidget(
              error: state.message,
              onTap: () {
                ref
                    .watch(getPlaylistVideosNotifierProvider.notifier)
                    .getVideosInPlaylist(widget.playlistItem.id.toString());
              });
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
