
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../domain/usecase/get_playlist_videos.dart';
import 'get_playlist_videos_state.dart';

class GetPlaylistVideosNotifier extends StateNotifier<GetPlaylistVideosState> {
  GetPlaylistVideos getPlaylistVideos;
  GetPlaylistVideosNotifier(this.getPlaylistVideos) : super(const GetPlaylistVideosInitial());

  getVideosInPlaylist(String playlistId) async {
    print("playlistID $playlistId");

    try {
      state = const GetPlaylistVideosLoading();
      var result = await getPlaylistVideos(playlistId);
      result.fold((l) => null, (r) {
        print("playlistVideos ${r.items![0].snippet?.description}");
        state = GetPlaylistVideosLoaded(r.items!);
      });
    } catch (e) {
      state = GetPlaylistVideosError(message: "An error occured");
    }
  }
}