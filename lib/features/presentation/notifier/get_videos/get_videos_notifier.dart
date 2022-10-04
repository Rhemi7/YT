import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/usecase/get_next_videos.dart';
import 'get_videos_state.dart';

class GetVideosNotifier extends StateNotifier<GetVideosState> {
  GetVideos getVideos;
  GetNextVideos getNextVideos;
  List<VideoItem> _videosList = [];
  List<VideoItem> get videosList => _videosList;

  String nextPageToken = "";
  GetVideosNotifier({required this.getVideos, required this.getNextVideos})
      : super(const GetVideosInitial());

  getChannelVideos(String order) async {
    state = const GetVideosLoading();
    var result = await getVideos(order);
    result.fold((failure) {
      state = GetVideosError(mapFailureToMessage(failure));
    }, (r) {
      _videosList = r.items!;
      nextPageToken = r.nextPageToken.toString();
      state = GetVideosLoaded(r.items!);
    });
  }

  getNextChannelVideos({required String order}) async {
    var result = await getNextVideos(
        NextVideosParam(pageToken: nextPageToken, order: order));
    result.fold((failure) {
      state = GetVideosError(mapFailureToMessage(failure));
    }, (r) {
      _videosList.addAll(r.items!);
      nextPageToken = r.nextPageToken.toString();
      state = GetVideosLoaded(_videosList);
    });
  }
}
