import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/features/domain/usecase/add_to_search.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';
import 'package:youtube_data_api/features/domain/usecase/get_local_searches.dart';
import 'package:youtube_data_api/features/domain/usecase/get_search_results.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_channel/get_channel_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_playlist/get_playlist_state.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_notifier.dart';
import 'package:youtube_data_api/features/presentation/notifier/get_videos/get_videos_state.dart';

import '../../../service_locator.dart';
import '../../domain/usecase/get_next_playlist.dart';
import '../../domain/usecase/get_next_videos.dart';
import '../../domain/usecase/get_playlist_videos.dart';
import '../notifier/get_playlist_videos/get_playlist_videos_notifier.dart';
import '../notifier/get_playlist_videos/get_playlist_videos_state.dart';
import '../notifier/get_search/get_search_notifier.dart';
import '../notifier/get_search/get_search_state.dart';

final getChannelProvider = Provider<GetChannel>((ref) => GetChannel(sl()));

final getChannelNotifierProvider =
    StateNotifierProvider<GetChannelNotifier, GetChannelState>(
        (ref) => GetChannelNotifier(ref.watch(getChannelProvider)));

//Videos Injection

final getVideosProvider = Provider<GetVideos>((ref) => GetVideos(sl()));

final getNextVideosProvider =
    Provider<GetNextVideos>((ref) => GetNextVideos(sl()));

final getVideosNotifierProvider =
    StateNotifierProvider<GetVideosNotifier, GetVideosState>((ref) =>
        GetVideosNotifier(
            getVideos: ref.watch(getVideosProvider),
            getNextVideos: ref.watch(getNextVideosProvider)));

//Playlist
final getPlaylistProvider = Provider<GetPlaylist>((ref) => GetPlaylist(sl()));

final getNextPlaylistProvider =
    Provider<GetNextPlaylist>((ref) => GetNextPlaylist(sl()));

final getPlaylistNotifierProvider =
    StateNotifierProvider<GetPlaylistNotifier, GetPlaylistState>((ref) =>
        GetPlaylistNotifier(
            getPlaylist: ref.watch(getPlaylistProvider),
            nextPlaylist: ref.watch(getNextPlaylistProvider)));

//Playlist Videos

final getPlaylistVideosProvider =
    Provider<GetPlaylistVideos>((ref) => GetPlaylistVideos(sl()));

final getPlaylistVideosNotifierProvider =
    StateNotifierProvider<GetPlaylistVideosNotifier, GetPlaylistVideosState>(
        (ref) =>
            GetPlaylistVideosNotifier(ref.watch(getPlaylistVideosProvider)));

final getSearchProvider =
    Provider<GetSearchResults>((ref) => GetSearchResults(sl()));

final getLocalSearchProvider =
    Provider<GetLocalSearch>((ref) => GetLocalSearch(sl()));

final addToSearchProvider = Provider<AddToSearch>((ref) => AddToSearch(sl()));

final getSearchNotifierProvider =
    StateNotifierProvider<GetSearchNotifier, GetSearchState>((ref) =>
        GetSearchNotifier(
            getSearchResults: ref.watch(getSearchProvider),
            getLocalSearches: ref.watch(getLocalSearchProvider),
            addToSearch: ref.watch(addToSearchProvider)));
