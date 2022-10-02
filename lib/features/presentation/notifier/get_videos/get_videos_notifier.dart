import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/usecase/get_latest_videos.dart';
import '../../../../core/usecases/usecases.dart';
import 'get_videos_state.dart';

class GetVideosNotifier extends StateNotifier<GetVideosState> {
  GetLatestVideos getLatestVideos;
  GetVideosNotifier(this.getLatestVideos) : super(const GetVideosInitial());

  getRecentVideos() async {
    try {
      state = const GetVideosLoading();
      var result = await getLatestVideos(NoParams());
      result.fold((l) => null, (r) {
        print("recent ${r.items!.length}");
        state = GetVideosLoaded(r.items!);
      });
    } catch (e) {
      print("error");
      state = GetVideosError("An error occurred");
    }
  }
}
