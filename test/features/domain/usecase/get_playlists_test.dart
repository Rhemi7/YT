import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';

class MockLatestVideoRepository extends Mock implements PlaylistRepository {}

void main() {

  MockLatestVideoRepository repository;
  GetPlaylist getPlaylist;

  final testPlaylistModel = PlaylistResponse(
      kind: "youtube#playlistListResponse",
      etag: "uzCxNou-1Q58M0GBb3IQGvzET1E",
      nextPageToken: "CBkQAA",
      pageInfo: PageInfo(totalResults: 164, resultsPerPage: 25),
      items:  const []);

  test(
    'should get playlist response from the repository',
        () async {
      repository = MockLatestVideoRepository();
      getPlaylist = GetPlaylist(repository);
      //stub the method
      when(repository.getPlaylist()).thenAnswer((_) async => Right(testPlaylistModel));
      // act
      final result = await getPlaylist( NoParams());
      // assert
      expect(result, Right(testPlaylistModel));
      verify(repository.getPlaylist());
      verifyNoMoreInteractions(repository);
    },
  );
}