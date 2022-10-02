

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/network_info.dart';
import 'package:youtube_data_api/features/data/datasources/get_videos_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/data/repository/get_latest_videos_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGetVideosRemoteDataSource extends Mock
    implements GetVideosRemoteDataSource {}

void main() {
  late MockGetVideosRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GetLatestVideosRepoImpl repository;

  mockRemoteDataSource = MockGetVideosRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = GetLatestVideosRepoImpl(
      networkInfo: mockNetworkInfo, remoteDatasource: mockRemoteDataSource);

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Get Latest Videos", () {
    final testVideosModel = VideosResponse(
        kind: "youtube#searchListResponse",
        etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
        regionCode: "US",
        nextPageToken: "CAUQAA",
        pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
        items:  const []);

    test(
      'should check if the device is online',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getLatestVideos();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getVideos())
              .thenAnswer((_) async => testVideosModel);
          // act
          final result = await repository.getLatestVideos();
          // assert
          verify(mockRemoteDataSource.getVideos());

          expect(result, equals(Right(testVideosModel)));
        },
      );
    });
  });
}