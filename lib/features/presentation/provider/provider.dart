import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_state.dart';

import '../../../service_locator.dart';
import '../../domain/usecase/get_next_videos.dart';
import '../../domain/usecase/get_playlist_videos.dart';
import '../notifier/get_playlist_videos/get_playlist_videos_notifier.dart';
import '../notifier/get_playlist_videos/get_playlist_videos_state.dart';

final getChannelProvider = Provider<GetChannel>((ref) => GetChannel(sl()));

final getChannelNotifierProvider = StateNotifierProvider<GetChannelNotifier, GetChannelState>((ref) => GetChannelNotifier(ref.watch(getChannelProvider)));

//Videos Injection

final getVideosProvider = Provider<GetVideos>((ref) => GetVideos(sl()));

final getNextVideosProvider = Provider<GetNextVideos>((ref) => GetNextVideos(sl()));

final getVideosNotifierProvider = StateNotifierProvider<GetVideosNotifier, GetVideosState>((ref) => GetVideosNotifier(getVideos:ref.watch(getVideosProvider), getNextVideos: ref.watch(getNextVideosProvider)));


//Playlist
final getPlaylistProvider = Provider<GetPlaylist>((ref) => GetPlaylist(sl()));

final getPlaylistNotifierProvider = StateNotifierProvider<GetPlaylistNotifier, GetPlaylistState>((ref) => GetPlaylistNotifier(ref.watch(getPlaylistProvider)));

//Playlist Videos

final getPlaylistVideosProvider = Provider<GetPlaylistVideos>((ref) => GetPlaylistVideos(sl()));

final getPlaylistVideosNotifierProvider = StateNotifierProvider<GetPlaylistVideosNotifier, GetPlaylistVideosState>((ref) => GetPlaylistVideosNotifier(ref.watch(getPlaylistVideosProvider)));