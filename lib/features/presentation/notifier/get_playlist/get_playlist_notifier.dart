import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';

import '../../../data/model/playlist_response.dart';
import '../../../domain/usecase/get_next_playlist.dart';
import 'get_playlist_state.dart';

class GetPlaylistNotifier extends StateNotifier<GetPlaylistState> {
  GetPlaylist getPlaylist;
  GetNextPlaylist nextPlaylist;

  String pageToken = "";
  String firstToken = "";
  List<Item> _playListList = [];
  List<Item> get playListList => _playListList;

  GetPlaylistNotifier({required this.getPlaylist, required this.nextPlaylist}) : super(const GetPlaylistInitial());

  getAllPlaylist() async {
    try {
      state = const GetPlaylistLoading();

      var result = await getPlaylist(NoParams());
      result.fold((l) => null, (r) {
        pageToken = r.nextPageToken!;
        _playListList = r.items!;
        state = GetPlaylistLoaded(r.items!);
      });
    } catch (e) {
      state = GetPlaylistError(message: "An error occured");
    }
  }

  getNextPlaylist() async {
    try {
      var result = await nextPlaylist(pageToken);
      result.fold((l) => null, (r) {
        _playListList.addAll(r.items!);
        pageToken = r.nextPageToken ?? r.prevPageToken!;
        state = GetPlaylistLoaded(_playListList);
      });
    } catch (e) {
      state = GetPlaylistError(message: "An error occured");
    }
  }
}
