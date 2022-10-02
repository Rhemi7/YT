import '../../../data/model/playlist_videos_response.dart';

abstract class GetPlaylistVideosState {
  const GetPlaylistVideosState();
}

class GetPlaylistVideosInitial extends GetPlaylistVideosState {
  const GetPlaylistVideosInitial();
}

class GetPlaylistVideosLoading extends GetPlaylistVideosState {
  const GetPlaylistVideosLoading();
}

class GetPlaylistVideosLoaded extends GetPlaylistVideosState {
  final List<Item>? items;
  GetPlaylistVideosLoaded(this.items);
}

class GetPlaylistVideosError extends GetPlaylistVideosState {
  String message;
  GetPlaylistVideosError({required this.message});
}