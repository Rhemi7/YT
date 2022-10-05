import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/widgets/video_tile_widget.dart';
import '../../../core/filter_enum.dart';
import '../../../utils/margin.dart';
import '../notifier/get_videos/get_videos_state.dart';
import '../provider/provider.dart';
import '../screens/play_video_screen.dart';
import 'app_error_widget.dart';
import 'filter_widget.dart';

class VideosTabView extends ConsumerStatefulWidget {
  const VideosTabView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<VideosTabView> createState() => _VideosTabViewState();
}

class _VideosTabViewState extends ConsumerState<VideosTabView> {
  ScrollController videosTabController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getVideosNotifierProvider.notifier).getChannelVideos('date');
    });
    videosTabController.addListener(() {
      if (videosTabController.position.pixels ==
          videosTabController.position.maxScrollExtent) {
        ref
            .watch(getVideosNotifierProvider.notifier)
            .getNextChannelVideos(order: "date");
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    videosTabController.dispose();
    super.dispose();
  }

  FilterType filterValue = FilterType.date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const YMargin(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilterWidget(
                text: "Date",
                buttonColor:
                    filterValue == FilterType.date ? Colors.red : Colors.grey,
                onTap: () {
                  if (filterValue != FilterType.date) {
                    filterValue = FilterType.date;

                    ref
                        .watch(getVideosNotifierProvider.notifier)
                        .getChannelVideos('date');
                    setState(() {});
                  }
                }),
            const XMargin(15),
            FilterWidget(
                text: "Views",
                buttonColor:
                    filterValue == FilterType.views ? Colors.red : Colors.grey,
                onTap: () {
                  if (filterValue != FilterType.views) {
                    filterValue = FilterType.views;
                    ref
                        .watch(getVideosNotifierProvider.notifier)
                        .getChannelVideos('viewCount');
                    setState(() {});
                  }
                }),
            const XMargin(15),
            FilterWidget(
                text: "Ratings",
                buttonColor:
                    filterValue == FilterType.rating ? Colors.red : Colors.grey,
                onTap: () {
                  if (filterValue != FilterType.rating) {
                    filterValue = FilterType.rating;

                    ref
                        .watch(getVideosNotifierProvider.notifier)
                        .getChannelVideos('rating');
                    setState(() {});
                  }
                }),
          ],
        ),
        const YMargin(15),
        Expanded(
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(getVideosNotifierProvider);
            if (state is GetVideosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetVideosLoaded) {
              return ListView.builder(
                itemCount: state.items!.length,
                controller: videosTabController,
                itemBuilder: (BuildContext context, int i) {
                  if (i == state.items!.length - 1) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(child: CircularProgressIndicator())),
                    );
                  }
                  return VideoTileWidget(
                    video: state.items![i],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayVideoScreen(
                                  videoId:
                                      state.items![i].id!.videoId.toString())));
                    },
                  );
                },
              );
            } else if (state is GetVideosError) {
              return AppErrorWidget(
                error: state.message,
                onTap: () {
                  ref
                      .watch(getVideosNotifierProvider.notifier)
                      .getChannelVideos('date');
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ],
    );
  }
}
