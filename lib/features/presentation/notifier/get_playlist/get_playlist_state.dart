import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';

import '../../../data/model/playlist_response.dart';

abstract class GetPlaylistState {
  const GetPlaylistState();
}

class GetPlaylistInitial extends GetPlaylistState {
  const GetPlaylistInitial();
}

class GetPlaylistLoading extends GetPlaylistState {
  const GetPlaylistLoading();
}

class GetPlaylistLoaded extends GetPlaylistState {
  final Item? item;
  GetPlaylistLoaded({this.item});
}

class GetPlaylistError extends GetPlaylistState {
  String message;
  GetPlaylistError({required this.message});
}