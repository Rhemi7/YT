import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_videos_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_next_videos.dart';

class MockGetVideosRepository extends Mock implements GetVideosRepository {}

void main() {

  MockGetVideosRepository repository;
  GetNextVideos getNextVideos;

  final testVideosModel = VideosResponse(
      kind: "youtube#searchListResponse",
      etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
      regionCode: "US",
      nextPageToken: "CAUQAA",
      prevPageToken:  "CDHSTE",
      pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
      items:  const []);

  test(
    'should get video response from the repository',
        () async {
      repository = MockGetVideosRepository();
      getNextVideos = GetNextVideos(repository);
      //stub the method
      when(repository.getNextVideos(order: "date", pageToken: "CAUQAA")).thenAnswer((_) async => Right(testVideosModel));
      // act
      final result = await getNextVideos(const NextVideosParam(order: "date", pageToken: "CAUQAA"));
      // assert
      expect(result, Right(testVideosModel));
      verify(repository.getNextVideos(order: "date", pageToken: "CAUQAA"));
      verifyNoMoreInteractions(repository);
    },
  );
}