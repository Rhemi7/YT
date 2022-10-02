

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

abstract class GetLatestVideosRepository {

  Future<Either<Failure, VideosResponse>> getLatestVideos();
}