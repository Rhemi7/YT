

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_latest_videos_repository.dart';

class GetLatestVideos extends UseCase<VideosResponse, NoParams> {
  GetLatestVideosRepository getLatestVideosRepository;
  GetLatestVideos(this.getLatestVideosRepository);

  @override
  Future<Either<Failure, VideosResponse>> call(NoParams params) async {
   return await getLatestVideosRepository.getLatestVideos();
  }


}