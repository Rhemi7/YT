import 'package:youtube_data_api/features/data/model/channel_response.dart';

abstract class GetChannelState {
  const GetChannelState();
}

class GetChannelInitial extends GetChannelState {
  const GetChannelInitial();
}

class GetChannelLoading extends GetChannelState {
  const GetChannelLoading();
}

class GetChannelLoaded extends GetChannelState {
  final ChannelItem? item;
  GetChannelLoaded({this.item});
}

class GetChannelError extends GetChannelState {
  String message;
  GetChannelError({required this.message});
}
