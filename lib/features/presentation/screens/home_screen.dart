import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_state.dart';
import 'package:youtube_data_api/features/presentation/provider/provider.dart';
import 'package:youtube_data_api/features/presentation/view_model/home_view_model.dart';
import 'package:youtube_data_api/features/presentation/widgets/video_tile_widget.dart';
import 'package:youtube_data_api/helper/number_formatter.dart';
import '../../../constants/const.dart';
import '../../../constants/styles.dart';
import '../../../service_locator.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
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
  void initState() {
    tabController = TabController(vsync: this, length: 5);
    HomeViewModel(sl()).channel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getChannelNotifierProvider.notifier).getFavChannel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(getVideosNotifierProvider.notifier);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            channelName.toUpperCase(),
          ),
          centerTitle: false,
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
                Tab(
                  child: Text(
                    info,
                    style: TextStyle(
                      fontSize: Resolution.textSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    info,
                    style: TextStyle(
                      fontSize: Resolution.textSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Consumer(builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          final channelState =
                              ref.watch(getChannelNotifierProvider);
                          if (channelState is GetChannelLoading) {
                            return const CircularProgressIndicator();
                          } else if (channelState is GetChannelLoaded) {
                            return Column(
                              children: [
                                Container(
                                  width: Resolution.screenWidth(context),
                                  height: Resolution.screenHeight(context,
                                      percent: 0.12),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(channelState
                                                  .item!
                                                  .brandingSettings!
                                                  .image!
                                                  .bannerExternalUrl
                                                  .toString()
                                              // channelState.item.brandingSettings.image!.bannerExternalUrl
                                              ),
                                          fit: BoxFit.fitWidth)),
                                ),
                                const Center(child: YMargin(10)),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: NetworkImage(channelState
                                      .item!
                                      .snippet!
                                      .thumbnails!
                                      .thumbnailsDefault!
                                      .url
                                      .toString()),
                                ),
                                const YMargin(15),
                                Text(
                                  channelState.item!.snippet!.title.toString(),
                                  style: AppTextStyle.headingText.copyWith(
                                      fontSize:
                                          Resolution.textSize(context, 22)),
                                ),
                                const YMargin(15),
                                Text(
                                  "${NumberFormatter.formatter(channelState.item!.statistics!.subscriberCount.toString())} subscribers",
                                  style: TextStyle(
                                    fontSize: Resolution.textSize(context, 16),
                                  ),
                                ),
                                const YMargin(15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    channelState.item!.snippet!.description
                                        .toString(),
                                    style: TextStyle(
                                        fontSize:
                                            Resolution.textSize(context, 16),
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        // if (provider.listItem.isNotEmpty)
                        //   for (int i = 0; i < 3; i++)
                        //     // for(var item in state.items!) {
                        //
                        //     VideoTileWidget(video: provider.listItem[i])

                        // Consumer(builder: (BuildContext context, WidgetRef ref,
                        //     Widget? child) {
                        //   final state = ref.watch(getVideosNotifierProvider);
                        //   if (state is GetVideosLoading) {
                        //     return const CircularProgressIndicator();
                        //   } else if (state is GetVideosLoaded) {
                        //     for (int i = 0; i < 3; i++) {
                        //       // for(var item in state.items!) {
                        //
                        //       return VideoTileWidget(
                        //           video: provider.listItem[i]);
                        //     }
                        //     print('videos loaded');
                        //     // Container(
                        //     //   height: 200,
                        //     //   child: ListView.builder(
                        //     //     itemCount: 3,
                        //     //     itemBuilder: (BuildContext context, int i) {
                        //     //       return VideoTileWidget(
                        //     //         video:state.items![i] ,
                        //     //       );
                        //     //     },
                        //     //   ),
                        //     // );
                        //   }
                        //   return const SizedBox.shrink();
                        // })
                      ],
                    ),
                  ),
                  VideosTabView(),
                  PlaylistTabView(),
                  Column(
                    children: [
                      Container(
                        width: Resolution.screenWidth(context),
                        height: Resolution.screenHeight(context, percent: 0.12),
                        color: Colors.greenAccent,
                      ),
                      const Center(child: YMargin(10)),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                      ),
                      const YMargin(15),
                      const Text(
                        channelName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                      const YMargin(15),
                      const Text(
                        "2M subscribers",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const YMargin(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade400),
                        ),
                      ),
                      // const YMargin(15),
                      // Container(
                      //   height: 300,
                      //   child: ListView.builder(
                      //     itemCount: 3,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(left: 10.0, top: 15),
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               width: Resolution.screenWidth(context, percent: 0.45),
                      //               height: Resolution.screenHeight(context, percent: 0.14),
                      //               color: Colors.greenAccent,
                      //             ),
                      //             const XMargin(10),
                      //             Expanded(
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   const Text(
                      //                       'First line First line First line First line'),
                      //                   Text(
                      //                     'Second Line',
                      //                     style: AppTextStyle.descText.copyWith(fontSize: 11),
                      //                   ),
                      //                   Text(
                      //                     'Third line',
                      //                     style: AppTextStyle.descText.copyWith(fontSize: 11),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             InkWell(
                      //                 onTap: () {},
                      //                 child: const Padding(
                      //                   padding: EdgeInsets.symmetric(horizontal: 5.0),
                      //                   child: Icon(
                      //                     Icons.share_rounded,
                      //                     size: 12,
                      //                   ),
                      //                 ))
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                      for (int i = 0; i < 3; i++)
                        const VideoTileWidget(
                          title: "First line First line First line First line",
                          creator: 'Second Line',
                          date: "Third line 2",
                          views: "Third line 3",
                        )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: Resolution.screenWidth(context),
                        height: Resolution.screenHeight(context, percent: 0.12),
                        color: Colors.greenAccent,
                      ),
                      const Center(child: YMargin(10)),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                      ),
                      const YMargin(15),
                      const Text(
                        channelName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                      const YMargin(15),
                      const Text(
                        "2M subscribers",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const YMargin(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade400),
                        ),
                      ),
                      // const YMargin(15),
                      // Container(
                      //   height: 300,
                      //   child: ListView.builder(
                      //     itemCount: 3,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(left: 10.0, top: 15),
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               width: Resolution.screenWidth(context, percent: 0.45),
                      //               height: Resolution.screenHeight(context, percent: 0.14),
                      //               color: Colors.greenAccent,
                      //             ),
                      //             const XMargin(10),
                      //             Expanded(
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   const Text(
                      //                       'First line First line First line First line'),
                      //                   Text(
                      //                     'Second Line',
                      //                     style: AppTextStyle.descText.copyWith(fontSize: 11),
                      //                   ),
                      //                   Text(
                      //                     'Third line',
                      //                     style: AppTextStyle.descText.copyWith(fontSize: 11),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             InkWell(
                      //                 onTap: () {},
                      //                 child: const Padding(
                      //                   padding: EdgeInsets.symmetric(horizontal: 5.0),
                      //                   child: Icon(
                      //                     Icons.share_rounded,
                      //                     size: 12,
                      //                   ),
                      //                 ))
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                      for (int i = 0; i < 3; i++)
                        const VideoTileWidget(
                          title: "First line First line First line First line",
                          creator: 'Second Line',
                          date: "Third line 2",
                          views: "Third line 3",
                        )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getVideosNotifierProvider.notifier).getRecentVideos();
    });
    super.initState();
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
          itemBuilder: (BuildContext context, int i) {
            return VideoTileWidget(
              video: state.items![i],
            );
          },
        );
        // }
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getPlaylistNotifierProvider.notifier).getAllPlaylist();
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
          itemBuilder: (BuildContext context, int i) {
            return PlaylistTileWidget(playlist: state.items![i]);
          },
        );
        // }
      }
      return const SizedBox.shrink();
    });
  }
}
