import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/network_info.dart';
import 'package:youtube_data_api/features/data/datasources/playlist_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart' as plv;
import 'package:youtube_data_api/features/data/repository/playlist_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGetPlaylistRemoteDataSource extends Mock
    implements PlaylistRemoteDataSource {}

void main() {
  late MockGetPlaylistRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late PlaylistRepoImpl repository;

  String playlistID = "PLOU2XLYxmsIIjHK9mEgLey-CaFcajdUBX";


  mockRemoteDataSource = MockGetPlaylistRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = PlaylistRepoImpl(
      networkInfo: mockNetworkInfo, remoteDatasource: mockRemoteDataSource);

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Get Playlist", () {
    final testPlaylistModel = PlaylistResponse(
        kind: "youtube#playlistListResponse",
        etag: "uzCxNou-1Q58M0GBb3IQGvzET1E",
        nextPageToken: "CBkQAA",
        prevPageToken: "CDHSTE",
        pageInfo: PageInfo(totalResults: 164, resultsPerPage: 25),
        items:  const []);

    test(
      'should check if the device is online',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getPlaylist();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPlaylist())
              .thenAnswer((_) async => testPlaylistModel);
          // act
          final result = await repository.getPlaylist();
          // assert
          verify(mockRemoteDataSource.getPlaylist());

          expect(result, equals(Right(testPlaylistModel)));
        },
      );
    });
  });

  group("Get Videos in Playlist", () {
    final testPlaylistVideoModel = plv.PlaylistVideoResponse(
        kind: "youtube#playlistItemListResponse",
        etag: "JLBFmIcpInGbggWalPwqWLJZyVM",
        nextPageToken: "EAAaBlBUOkNBVQ",
        pageInfo: plv.PageInfo(totalResults: 15, resultsPerPage: 5),
        items:  []);

    test(
      'should check if the device is online',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getPlayListVideos(playlistID);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPlayListVideos(playlistID))
              .thenAnswer((_) async => testPlaylistVideoModel);
          // act
          final result = await repository.getPlayListVideos(playlistID);
          // assert
          verify(mockRemoteDataSource.getPlayListVideos(playlistID));

          expect(result, equals(Right(testPlaylistVideoModel)));
        },
      );
    });
  });
}