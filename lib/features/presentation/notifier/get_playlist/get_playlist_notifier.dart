import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';

import 'get_playlist_state.dart';

class GetPlaylistNotifier extends StateNotifier<GetPlaylistState> {
  GetPlaylist getPlaylist;
  GetPlaylistNotifier(this.getPlaylist) : super(const GetPlaylistInitial());

  getAllPlaylist() async {
    try {
      state = const GetPlaylistLoading();

      var result = await getPlaylist(NoParams());
      result.fold((l) => null, (r) {
        print("playlist ${r.items![0].snippet?.description}");
        state = GetPlaylistLoaded(item: r.items![0]);
      });
    } catch (e) {
      state = GetPlaylistError(message: "An error occured");
    }
  }
}
