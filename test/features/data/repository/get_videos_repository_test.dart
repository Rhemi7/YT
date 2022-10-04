

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/network_info.dart';
import 'package:youtube_data_api/features/data/datasources/get_videos_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/data/repository/get_videos_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGetVideosRemoteDataSource extends Mock
    implements GetVideosRemoteDataSource {}

void main() {
  late MockGetVideosRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GetVideosRepoImpl repository;

  mockRemoteDataSource = MockGetVideosRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = GetVideosRepoImpl(
      networkInfo: mockNetworkInfo, remoteDatasource: mockRemoteDataSource);

  String order = "date";
  String pageToken = "CAUQAA";

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Get Videos", () {
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
        await repository.getVideos(order);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getVideos(order))
              .thenAnswer((_) async => testVideosModel);
          // act
          final result = await repository.getVideos(order);
          // assert
          verify(mockRemoteDataSource.getVideos(order));

          expect(result, equals(Right(testVideosModel)));
        },
      );
    });
  });

  group("Get Next Videos", () {
    final testVideosModel = VideosResponse(
        kind: "youtube#searchListResponse",
        etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
        regionCode: "US",
        prevPageToken:  "CDHSTE",
        nextPageToken: "CAUQAA",
        pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
        items:  const []);

    test(
      'should check if the device is online',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getNextVideos(order: "date", pageToken: "CAUQAA");
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNextVideos(order: order, pageToken: pageToken))
              .thenAnswer((_) async => testVideosModel);
          // act
          final result = await repository.getNextVideos(order: order, pageToken: pageToken);
          // assert
          verify(mockRemoteDataSource.getNextVideos(order: order, pageToken: pageToken));

          expect(result, equals(Right(testVideosModel)));
        },
      );
    });
  });
}