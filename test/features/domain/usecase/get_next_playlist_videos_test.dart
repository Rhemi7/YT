import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_next_playlist_videos.dart';

class MockPlaylistRepository extends Mock implements PlaylistRepository {}

void main() {
  MockPlaylistRepository repository;
  GetNextPlaylistVideos getNextPlaylistVideos;

  String playlistID = "PLOU2XLYxmsIIjHK9mEgLey-CaFcajdUBX";
  String pageToken = "EAAaBlBUOkNBVQ";

  final testPlaylistVideoModel = PlaylistVideoResponse(
      kind: "youtube#playlistItemListResponse",
      etag: "JLBFmIcpInGbggWalPwqWLJZyVM",
      nextPageToken: "EAAaBlBUOkNBVQ",
      prevPageToken: "EAAaBlBUOkNBVA",
      pageInfo: PageInfo(totalResults: 15, resultsPerPage: 5),
      items: const []);

  test(
    'should get next set of playlist videos response from the repository',
        () async {
      repository = MockPlaylistRepository();
      getNextPlaylistVideos = GetNextPlaylistVideos(repository);
      //stub the method
      when(repository.getNextPlayListVideos(playlistID: playlistID, pageToken: pageToken))
          .thenAnswer((_) async => Right(testPlaylistVideoModel));
      // act
      final result = await getNextPlaylistVideos(NextPlaylistVideos(pageToken: pageToken, playlistID: playlistID));
      // assert
      expect(result, Right(testPlaylistVideoModel));
      verify(repository.getNextPlayListVideos(playlistID: playlistID, pageToken: pageToken));
      verifyNoMoreInteractions(repository);
    },
  );
}