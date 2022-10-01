import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';

abstract class ChannelRepository {
  Future<Either<Failure, ChannelResponse>> getChannel();
}
