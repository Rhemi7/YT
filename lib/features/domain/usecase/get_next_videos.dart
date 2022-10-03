
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecases/usecases.dart';
import '../../data/model/videos_response.dart';
import '../repository/get_videos_repository.dart';

class GetNextVideos extends UseCase<VideosResponse, NextVideosParam> {
  GetVideosRepository getVideosRepository;
  GetNextVideos(this.getVideosRepository);

  @override
  Future<Either<Failure, VideosResponse>> call(NextVideosParam params) async {
    return await getVideosRepository.getNextVideos(order: params.order, pageToken: params.pageToken);
  }
}

class NextVideosParam extends Equatable{
  final String? pageToken;
  final String? order;

  const NextVideosParam({this.pageToken, this.order});

  @override
  List<Object?> get props => [pageToken, order];
}