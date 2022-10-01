import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/network_info.dart';
import 'package:youtube_data_api/features/data/datasources/get_channel_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';
import 'package:youtube_data_api/features/data/repository/get_channel_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGetChannelRemoteDataSource extends Mock
    implements GetChannelRemoteDataSource {}

void main() {
  late MockGetChannelRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ChannelRepoImpl repository;

  mockRemoteDataSource = MockGetChannelRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = ChannelRepoImpl(
      networkInfo: mockNetworkInfo, remoteDatasource: mockRemoteDataSource);

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Get Channel", () {
    final testChannelModel = ChannelResponse(
        kind: "youtube#channelListResponse",
        etag: "unNk2YuUkMPxKv50PV_Azhpx6Ao",
        pageInfo: PageInfo(totalResults: 1, resultsPerPage: 5),
        items: const []);

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getChannel();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getChannel())
              .thenAnswer((_) async => testChannelModel);
          // act
          final result = await repository.getChannel();
          // assert
          verify(mockRemoteDataSource.getChannel());

          expect(result, equals(Right(testChannelModel)));
        },
      );
    });
  });
}
