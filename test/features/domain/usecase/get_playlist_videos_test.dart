import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlist_videos.dart';

class MockPlaylistRepository extends Mock implements PlaylistRepository {}

void main() {

  MockPlaylistRepository repository;
  GetPlaylistVideos getPlaylistVideos;

  String playlistID = "PLOU2XLYxmsIIjHK9mEgLey-CaFcajdUBX";


  final testPlaylistVideoModel = PlaylistVideoResponse(
      kind: "youtube#playlistItemListResponse",
      etag: "JLBFmIcpInGbggWalPwqWLJZyVM",
      nextPageToken: "EAAaBlBUOkNBVQ",
      pageInfo: PageInfo(totalResults: 15, resultsPerPage: 5),
      items:  const []);

  test(
    'should get playlist videos response from the repository',
        () async {
      repository = MockPlaylistRepository();
      getPlaylistVideos = GetPlaylistVideos(repository);
      //stub the method
      when(repository.getPlayListVideos(playlistID)).thenAnswer((_) async => Right(testPlaylistVideoModel));
      // act
      final result = await getPlaylistVideos(playlistID);
      // assert
      expect(result, Right(testPlaylistVideoModel));
      verify(repository.getPlayListVideos(playlistID));
      verifyNoMoreInteractions(repository);
    },
  );
}