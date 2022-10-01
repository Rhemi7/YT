import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel_state.dart';

import '../../../service_locator.dart';

final getChannelProvider = Provider<GetChannel>((ref) => GetChannel(sl()));

final getChannelNotifierProvider = StateNotifierProvider<GetChannelNotifier, GetChannelState>((ref) => GetChannelNotifier(ref.watch(getChannelProvider)));