

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_videos_repository.dart';

class GetVideos extends UseCase<VideosResponse, String> {
  GetVideosRepository getVideosRepository;
  GetVideos(this.getVideosRepository);

  @override
  Future<Either<Failure, VideosResponse>> call(String params) async {
   return await getVideosRepository.getVideos(params);
  }
}

