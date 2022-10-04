import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_videos_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';

class MockGetVideosRepository extends Mock implements GetVideosRepository {}

void main() {

  MockGetVideosRepository repository;
  GetVideos getVideos;

  final testVideosModel = VideosResponse(
      kind: "youtube#searchListResponse",
      etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
      regionCode: "US",
      nextPageToken: "CAUQAA",
      pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
      items:  const []);

  test(
    'should get video response from the repository',
        () async {
      repository = MockGetVideosRepository();
      getVideos = GetVideos(repository);
      //stub the method
      when(repository.getVideos('date')).thenAnswer((_) async => Right(testVideosModel));
      // act
      final result = await getVideos('date');
      // assert
      expect(result, Right(testVideosModel));
      verify(repository.getVideos('date'));
      verifyNoMoreInteractions(repository);
    },
  );
}