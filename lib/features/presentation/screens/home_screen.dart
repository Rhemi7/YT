import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/presentation/widgets/video_tile_widget.dart';

import '../../../main.dart';
import '../../constants/const.dart';
import '../../utils/margin.dart';
import '../../utils/resolution.dart';
import '../widgets/playlist_tile_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            const TabBar(
              // controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    home,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    videos,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    playlists,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    info,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    info,
                    style: TextStyle(
                      fontSize: 14,
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
                        Container(
                          width: Resolution.screenWidth(context),
                          height:
                          Resolution.screenHeight(context, percent: 0.12),
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
                        for (int i = 0; i < 3; i++)
                          const VideoTileWidget(
                            title:
                            "First line First line First line First line",
                            creator: 'Second Line',
                            date: "Third line 2",
                            views: "Third line 3",
                          )
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const VideoTileWidget(
                        title: "First line First line First line First line",
                        creator: 'Second Line',
                        date: "Third line 2",
                        views: "Third line 3",
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const PlaylistTileWidget();
                    },
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