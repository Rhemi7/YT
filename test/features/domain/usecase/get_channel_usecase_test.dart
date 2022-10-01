

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';
import 'package:youtube_data_api/features/domain/repository/get_channel_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';

class MockChannelRepository extends Mock implements ChannelRepository {}

void main() {

  MockChannelRepository repository;
  GetChannel usecase;

  final testChannelModel = ChannelResponse(
      kind: "youtube#channelListResponse",
      etag: "unNk2YuUkMPxKv50PV_Azhpx6Ao",
      pageInfo: PageInfo(totalResults: 1, resultsPerPage: 5),
      items: const []);

  test(
    'should get channel response from the repository',
        () async {
      repository = MockChannelRepository();
      usecase = GetChannel(repository);
      //stub the method
      when(repository.getChannel()).thenAnswer((_) async => Right(testChannelModel));
      // act
      final result = await usecase( NoParams());
      // assert
      expect(result, Right(testChannelModel));
      verify(repository.getChannel());
      verifyNoMoreInteractions(repository);
    },
  );
}