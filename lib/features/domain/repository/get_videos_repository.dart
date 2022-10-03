

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

abstract class GetVideosRepository {

  Future<Either<Failure, VideosResponse>> getVideos();
  Future<Either<Failure, VideosResponse>> getNextVideos({String? order, String? pageToken});
}