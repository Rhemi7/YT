

import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';

class HomeViewModel {

  GetChannel getChannelUsecase;
  // = GetChannel(sl());
  HomeViewModel(this.getChannelUsecase);
  channel() async {
    var result = await getChannelUsecase(NoParams());
    result.fold((l) => null, (r) {
      print("channel ${r.items![0].snippet!.customUrl}");
    });
  }
}