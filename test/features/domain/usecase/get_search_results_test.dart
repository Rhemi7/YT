import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/search_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_search_results.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {

  MockSearchRepository repository;
  GetSearchResults getSearchResults;

  final testSearchVideosModel = VideosResponse(
      kind: "youtube#searchListResponse",
      etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
      regionCode: "US",
      nextPageToken: "CAUQAA",
      pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
      items:  const []);

  test(
    'should get search video response from the repository',
        () async {
      repository = MockSearchRepository();
      getSearchResults = GetSearchResults(repository);
      //stub the method
      when(repository.getSearch('flutter')).thenAnswer((_) async => Right(testSearchVideosModel));
      // act
      final result = await getSearchResults('flutter');
      // assert
      expect(result, Right(testSearchVideosModel));
      verify(repository.getSearch("flutter"));
      verifyNoMoreInteractions(repository);
    },
  );
}