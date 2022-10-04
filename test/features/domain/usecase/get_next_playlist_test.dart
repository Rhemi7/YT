
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_next_playlist.dart';

class MockPlaylistRepository extends Mock implements PlaylistRepository {}

void main() {
  String pageToken = "CBKQAA";


  MockPlaylistRepository repository;
  GetNextPlaylist getNextPlaylist;

  final testPlaylistModel = PlaylistResponse(
      kind: "youtube#playlistListResponse",
      etag: "uzCxNou-1Q58M0GBb3IQGvzET1E",
      nextPageToken: "CBkQAA",
      prevPageToken: "CDHSTE",
      pageInfo: PageInfo(totalResults: 164, resultsPerPage: 25),
      items:  const []);

  test(
    'should get next playlist response from the repository',
        () async {
      repository = MockPlaylistRepository();
      getNextPlaylist = GetNextPlaylist(repository);
      //stub the method
      when(repository.getNextPlaylist(pageToken)).thenAnswer((_) async => Right(testPlaylistModel));
      // act
      final result = await getNextPlaylist(pageToken);
      // assert
      expect(result, Right(testPlaylistModel));
      verify(repository.getNextPlaylist(pageToken));
      verifyNoMoreInteractions(repository);
    },
  );
}