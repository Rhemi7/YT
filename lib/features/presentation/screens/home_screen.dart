import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_state.dart';
import 'package:youtube_data_api/features/presentation/provider/provider.dart';
import 'package:youtube_data_api/features/presentation/screens/play_video_screen.dart';
import 'package:youtube_data_api/features/presentation/view_model/home_view_model.dart';
import 'package:youtube_data_api/features/presentation/widgets/search_bottom_sheet.dart';
import 'package:youtube_data_api/features/presentation/widgets/video_tile_widget.dart';
import 'package:youtube_data_api/helper/number_formatter.dart';
import '../../../constants/const.dart';
import '../../../constants/styles.dart';
import '../../../service_locator.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/channel_response.dart';
import '../widgets/playlist_tile_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(getVideosNotifierProvider.notifier);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            channelName.toUpperCase(),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: AppStyle.modalBottomSheetCurve,
                      isScrollControlled: true,
                      builder: (context) {
                        return SearchBottomSheet(
                            // earnings: _earnings,
                            );
                      });
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [
            TabBar(
              // controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    home,
                    style: TextStyle(
                      fontSize: Resolution.textSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    videos,
                    style: TextStyle(
                      fontSize: Resolution.textSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    playlists,
                    style: TextStyle(
                      fontSize: Resolution.textSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  HomeTabView(),
                  VideosTabView(),
                  PlaylistTabView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeTabView extends ConsumerStatefulWidget {
  const HomeTabView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ConsumerState<HomeTabView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getChannelNotifierProvider.notifier).getFavChannel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final channelState = ref.watch(getChannelNotifierProvider);
            if (channelState is GetChannelLoading) {
              return const CircularProgressIndicator();
            } else if (channelState is GetChannelLoaded) {
              return MainHomeView(
                item: channelState.item!,
              );
            } else if (channelState is GetChannelError) {
              return AppErrorWidget(
                error: channelState.message,
                onTap: () {
                  ref
                      .watch(getChannelNotifierProvider.notifier)
                      .getFavChannel();
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key, required this.error, required this.onTap})
      : super(key: key);

  final String error;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        YMargin(Resolution.screenHeight(context, percent: 0.3)),
        Center(
            child: Text(
          error,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )),
        const YMargin(20),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            width: 100,
            color: Colors.red,
            child: const Center(
                child: Text(
              'Retry',
              style: TextStyle(fontSize: 18),
            )),
          ),
        )
      ],
    );
  }
}

class MainHomeView extends StatelessWidget {
  final Item item;
  const MainHomeView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Resolution.screenWidth(context),
          height: Resolution.screenHeight(context, percent: 0.12),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item
                      .brandingSettings!.image!.bannerExternalUrl
                      .toString()),
                  fit: BoxFit.fitWidth)),
        ),
        const Center(child: YMargin(10)),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          backgroundImage: NetworkImage(
              item.snippet!.thumbnails!.thumbnailsDefault!.url.toString()),
        ),
        const YMargin(15),
        Text(
          item.snippet!.title.toString(),
          style: AppStyle.headingText
              .copyWith(fontSize: Resolution.textSize(context, 22)),
        ),
        const YMargin(15),
        Text(
          "${NumberFormatter.formatter(item.statistics!.subscriberCount.toString())} subscribers",
          style: TextStyle(
            fontSize: Resolution.textSize(context, 16),
          ),
        ),
        const YMargin(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            item.snippet!.description.toString(),
            style: TextStyle(
                fontSize: Resolution.textSize(context, 16),
                color: Colors.grey.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const XMargin(15),
              Flag.fromString(
                item.snippet!.country.toString(),
                height: 15,
                width: 30,
              ),
              const XMargin(15),
              Text(item.snippet!.country.toString())
            ],
          ),
        ),
        const YMargin(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const Icon(Icons.show_chart),
              const XMargin(15),
              Text(
                  "${NumberFormatter.formatter(item.statistics!.viewCount.toString())} Views")
            ],
          ),
        ),
      ],
    );
  }
}

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
      ref.watch(getVideosNotifierProvider.notifier).getChannelVideos();
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
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
                            videoId: state.items![i].id!.videoId.toString())));
              },
            );
          },
        );
      } else if (state is GetVideosError) {
        return AppErrorWidget(error: state.message, onTap: () {
          ref.watch(getVideosNotifierProvider.notifier).getChannelVideos();

        },);
      }
      return const SizedBox.shrink();
    });
  }
}

class PlaylistTabView extends ConsumerStatefulWidget {
  const PlaylistTabView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PlaylistTabView> createState() => _PlaylistTabViewState();
}

class _PlaylistTabViewState extends ConsumerState<PlaylistTabView> {
  ScrollController playlistTabController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getPlaylistNotifierProvider.notifier).getAllPlaylist();
    });
    playlistTabController.addListener(() {
      if (playlistTabController.position.pixels ==
          playlistTabController.position.maxScrollExtent) {
        ref.watch(getPlaylistNotifierProvider.notifier).getNextPlaylist();
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final state = ref.watch(getPlaylistNotifierProvider);
      if (state is GetPlaylistLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetPlaylistLoaded) {
        return ListView.builder(
          itemCount: state.items!.length,
          controller: playlistTabController,
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
            return PlaylistTileWidget(playlist: state.items![i]);
          },
        );
        // }
      } else if (state is GetPlaylistError) {
        return AppErrorWidget(error: state.message, onTap: () {
          ref.watch(getPlaylistNotifierProvider.notifier).getAllPlaylist();

        },);
      }
      return const SizedBox.shrink();
    });
  }
}
