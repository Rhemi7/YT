import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel_state.dart';
import '../../../core/usecases/usecases.dart';
import '../../domain/usecase/get_channel.dart';

class GetChannelNotifier extends StateNotifier<GetChannelState> {
  GetChannel getChannelUsecase;
  GetChannelNotifier(this.getChannelUsecase): super(const GetChannelInitial());

  getFavChannel() async {
    try {
      state = const GetChannelLoading();

      var result = await getChannelUsecase(NoParams());
      result.fold((l) => null, (r) {
        print("channelUrl ${r.items![0].snippet?.description}");
        state = GetChannelLoaded(item: r.items![0]);
      });
    } catch (e) {
      state = GetChannelError(message: "An error occured");
    }

  }



}