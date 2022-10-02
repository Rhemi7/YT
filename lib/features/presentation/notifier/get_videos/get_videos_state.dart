

import 'package:youtube_data_api/features/data/model/videos_response.dart';

abstract class GetVideosState {
  const GetVideosState();
}

class GetVideosInitial extends GetVideosState{
  const GetVideosInitial();
}

class GetVideosLoading extends GetVideosState {
  const GetVideosLoading();
}

class GetVideosLoaded extends GetVideosState {
  final List<Item>? items;
  const GetVideosLoaded(this.items);
}

class GetVideosError extends GetVideosState {
  String message;
  GetVideosError(this.message);
}