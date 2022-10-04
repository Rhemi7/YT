
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/usecase/get_playlist_videos.dart';
import 'get_playlist_videos_state.dart';

class GetPlaylistVideosNotifier extends StateNotifier<GetPlaylistVideosState> {
  GetPlaylistVideos getPlaylistVideos;
  GetPlaylistVideosNotifier(this.getPlaylistVideos) : super(const GetPlaylistVideosInitial());

  getVideosInPlaylist(String playlistId) async {
     state = const GetPlaylistVideosLoading();
      var result = await getPlaylistVideos(playlistId);
      result.fold((failure) {
        state = GetPlaylistVideosError(message: mapFailureToMessage(failure));
      }, (r) {
        state = GetPlaylistVideosLoaded(r.items!);
      });

  }
}