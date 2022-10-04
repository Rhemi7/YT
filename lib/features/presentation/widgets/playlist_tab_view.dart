import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/widgets/playlist_tile_widget.dart';
import '../notifier/get_playlist/get_playlist_state.dart';
import '../provider/provider.dart';
import 'app_error_widget.dart';

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
        return AppErrorWidget(
          error: state.message,
          onTap: () {
            ref.watch(getPlaylistNotifierProvider.notifier).getAllPlaylist();
          },
        );
      }
      return const SizedBox.shrink();
    });
  }
}
