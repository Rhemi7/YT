import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/widgets/search_bottom_sheet.dart';
import '../../../constants/const.dart';
import '../../../constants/styles.dart';
import '../../../utils/resolution.dart';
import '../widgets/home_tab_view.dart';
import '../widgets/playlist_tab_view.dart';
import '../widgets/video_tab_view.dart';

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
