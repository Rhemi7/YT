import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/network_info.dart';
import 'package:youtube_data_api/features/data/datasources/get_search_remote_datasource.dart';
import 'package:youtube_data_api/features/data/datasources/search_local_data_source.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/data/repository/search_repository_implementation.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSearchRemoteDataSource extends Mock
    implements SearchRemoteDatasource {}

class MockSearchLocalDataSource extends Mock
    implements SearchLocalDataSource {}

void main() {
  String query = "flutter";

  late MockSearchRemoteDataSource mockRemoteDataSource;
  late MockSearchLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late SearchRepositoryImpl repository;

  mockRemoteDataSource = MockSearchRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  mockLocalDataSource = MockSearchLocalDataSource();
  repository = SearchRepositoryImpl(
       mockRemoteDataSource, mockNetworkInfo, mockLocalDataSource);

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Get Search", () {
    final testSearchVideosModel = VideosResponse(
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
        await repository.getSearch(query);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSearch(query))
              .thenAnswer((_) async => testSearchVideosModel);
          // act
          final result = await repository.getSearch(query);
          // assert
          verify(mockRemoteDataSource.getSearch(query));

          expect(result, equals(Right(testSearchVideosModel)));
        },
      );
    });
  });
}