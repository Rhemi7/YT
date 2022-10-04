import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/error/failure.dart';
import '../../../data/model/playlist_videos_response.dart';
import '../../../domain/usecase/get_next_playlist_videos.dart';
import '../../../domain/usecase/get_playlist_videos.dart';
import 'get_playlist_videos_state.dart';

class GetPlaylistVideosNotifier extends StateNotifier<GetPlaylistVideosState> {
  GetPlaylistVideos getPlaylistVideos;
  GetNextPlaylistVideos getNextPlaylistVideos;
  GetPlaylistVideosNotifier(
      {required this.getPlaylistVideos, required this.getNextPlaylistVideos})
      : super(const GetPlaylistVideosInitial());

  String pageToken = "";
  List<Item> _playlistVideos = [];
  List<Item> get playlistVideos => _playlistVideos;

  getVideosInPlaylist(String playlistId) async {
    state = const GetPlaylistVideosLoading();
    var result = await getPlaylistVideos(playlistId);
    result.fold((failure) {
      state = GetPlaylistVideosError(message: mapFailureToMessage(failure));
    }, (r) {
      pageToken = r.nextPageToken ?? "";
      print(pageToken);
      _playlistVideos = r.items!;
      state = GetPlaylistVideosLoaded(r.items!);
    });
  }


  getNextVideosInPlaylist({required String playlistId}) async {
    print(playlistId);
    print(pageToken);
    var result = await getNextPlaylistVideos(NextPlaylistVideos(pageToken: pageToken, playlistID: playlistId));
    result.fold((l) {
      state = GetPlaylistVideosError(message: mapFailureToMessage(l));
    }, (r) {
      _playlistVideos.addAll(r.items!);
      pageToken = r.nextPageToken ?? r.prevPageToken!;
      print(_playlistVideos.length);
      state = GetPlaylistVideosLoaded(_playlistVideos);
    });
  }
}
