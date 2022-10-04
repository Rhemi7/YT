import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_search/get_search_state.dart';
import 'package:youtube_data_api/features/presentation/provider/provider.dart';
import 'package:youtube_data_api/utils/margin.dart';
import 'package:youtube_data_api/utils/resolution.dart';

import '../../data/model/videos_response.dart';
import '../screens/play_video_screen.dart';
import 'app_textfield.dart';
import 'search_tile.dart';

class SearchBottomSheet extends ConsumerStatefulWidget {
  SearchBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends ConsumerState<SearchBottomSheet> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      onSearch();
    });
    super.initState();
  }

  onSearch() {
    if (searchController.text.isEmpty) {
      ref.watch(getSearchNotifierProvider.notifier).getLocalSearch();
    } else {
      ref
          .watch(getSearchNotifierProvider.notifier)
          .getSearch(searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        height: Resolution.screenHeight(context, percent: 0.8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  AppTextfield(
                    searchController: searchController,
                    onChanged: (value) {
                      // if (searchController.text.isEmpty) {
                      //   ref.watch(getSearchNotifierProvider.notifier).getLocalSearch();
                      // }
                    },
                  ),
                ],
              ),
              const YMargin(15),
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                final state = ref.watch(getSearchNotifierProvider);
                if (state is GetSearchLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.items!.length,
                      itemBuilder: (BuildContext context, int i) {
                        Item res = state.items![i];
                        return SearchTile(
                            icon: searchController.text.isEmpty
                                ? const Icon(Icons.history)
                                : const Icon(Icons.search),
                            res: res,
                            onTap: () {
                              ref
                                  .watch(getSearchNotifierProvider.notifier)
                                  .addToLocalSearch(res);

                              searchController.clear();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayVideoScreen(
                                          videoId:
                                              res.id!.videoId.toString())));
                            });
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const YMargin(20);
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
