import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist_videos/get_playlist_videos_state.dart';
import '../../../constants/styles.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/playlist_response.dart';
import '../provider/provider.dart';
import '../widgets/playlist_video_tile_widget.dart';
import '../widgets/video_tile_widget.dart';

class PlaylistInfoScreen extends ConsumerStatefulWidget {
  static const routeName = "playlist_info_screen";
  final Item playlistItem;

  const PlaylistInfoScreen({Key? key, required this.playlistItem})
      : super(key: key);

  @override
  ConsumerState<PlaylistInfoScreen> createState() => _PlaylistInfoScreenState();
}

class _PlaylistInfoScreenState extends ConsumerState<PlaylistInfoScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(getPlaylistVideosNotifierProvider.notifier)
          .getVideosInPlaylist(widget.playlistItem.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(getPlaylistVideosNotifierProvider);
        if (state is GetPlaylistVideosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetPlaylistVideosLoaded) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.playlistItem.snippet!.title!.toString(),
                  style: AppTextStyle.headingText
                      .copyWith(fontWeight: FontWeight.w600, fontSize: Resolution.textSize(context, 22)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.playlistItem.snippet!.channelTitle.toString(),
                  style: AppTextStyle.headingText
                      .copyWith(fontWeight: FontWeight.w500, fontSize: Resolution.textSize(context, 17)),
                ),
              ),
              const YMargin(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.playlistItem.snippet!.description.toString(),
                  style: AppTextStyle.descText.copyWith(fontSize: Resolution.textSize(context, 16)),
                ),
              ),
              const YMargin(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "${widget.playlistItem.contentDetails!.itemCount} Videos",
                  style: AppTextStyle.descText
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              ListView.builder(
                itemCount: state.items!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return PlaylistVideoTileWidget(
                    video: state.items![index],
                  );
                },
              ),
            ],
          );
        } else if (state is GetPlaylistVideosError) {
          Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
