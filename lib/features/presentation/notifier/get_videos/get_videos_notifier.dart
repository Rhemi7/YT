import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../domain/usecase/get_next_videos.dart';
import 'get_videos_state.dart';

class GetVideosNotifier extends StateNotifier<GetVideosState> {
  GetVideos getVideos;
  GetNextVideos getNextVideos;
  List<Item> _videosList = [];
  List<Item> get videosList => _videosList;

  String nextPageToken = "";
  GetVideosNotifier({required this.getVideos, required this.getNextVideos}) : super(const GetVideosInitial());

  getChannelVideos() async {
    try {
      state = const GetVideosLoading();
      var result = await getVideos(NoParams());
      result.fold((l) => null, (r) {
        _videosList = r.items!;
        nextPageToken = r.nextPageToken.toString();
        state = GetVideosLoaded(r.items!);
      });
    } catch (e) {
      print("error");
      state = GetVideosError("An error occurred");
    }
  }

  getNextChannelVideos({required String order}) async {
    try {
      var result = await getNextVideos(NextVideosParam(pageToken: nextPageToken, order: order));
      result.fold((l) => null, (r) {
        _videosList.addAll(r.items!);
        nextPageToken = r.nextPageToken.toString();
        state = GetVideosLoaded(_videosList);
      });
    } catch (e) {
      state = GetVideosError("An error occurred");
    }
  }
}
