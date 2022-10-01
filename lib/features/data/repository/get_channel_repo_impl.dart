import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_channel_repository.dart';
import '../../../core/network_info.dart';
import '../datasources/get_channel_remote_datasource.dart';

class ChannelRepoImpl implements ChannelRepository {
  final NetworkInfo networkInfo;
  GetChannelRemoteDataSource  remoteDatasource;
  ChannelRepoImpl({required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, ChannelResponse>> getChannel() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChannel = await remoteDatasource.getChannel();
        return Right(remoteChannel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}