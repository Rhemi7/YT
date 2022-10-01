

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_channel_repository.dart';

class GetChannel extends UseCase<ChannelResponse, NoParams> {
  ChannelRepository channelRepository;
  GetChannel(this.channelRepository);

  @override
  Future<Either<Failure, ChannelResponse>> call(NoParams params) async {
    return await channelRepository.getChannel();
  }


}