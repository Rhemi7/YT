import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_data_api/features/data/datasources/get_channel_remote_datasource.dart';
import 'package:youtube_data_api/features/data/datasources/playlist_remote_datasource.dart';
import 'package:youtube_data_api/features/data/datasources/get_videos_remote_datasource.dart';
import 'package:youtube_data_api/features/data/datasources/search_local_data_source.dart';
import 'package:youtube_data_api/features/data/repository/get_channel_repo_impl.dart';
import 'package:youtube_data_api/features/data/repository/get_videos_repo_impl.dart';
import 'package:youtube_data_api/features/data/repository/playlist_repo_impl.dart';
import 'package:youtube_data_api/features/data/repository/search_repository_implementation.dart';
import 'package:youtube_data_api/features/domain/repository/get_channel_repository.dart';
import 'package:youtube_data_api/features/domain/repository/get_videos_repository.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/add_to_search.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';
import 'package:youtube_data_api/features/domain/usecase/get_local_searches.dart';
import 'package:youtube_data_api/features/domain/usecase/get_search_results.dart';
import 'package:youtube_data_api/features/domain/usecase/get_videos.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlist_videos.dart';
import 'package:youtube_data_api/features/domain/usecase/get_playlists.dart';
import 'package:youtube_data_api/features/presentation/view_model/home_view_model.dart';

import 'core/network_info.dart';
import 'features/data/datasources/get_search_remote_datasource.dart';
import 'features/domain/repository/search_repository.dart';
import 'features/domain/usecase/get_next_videos.dart';




GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {

  //Http Client
  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);


  //Data connection
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //Channel
  sl.registerLazySingleton<GetChannelRemoteDataSource>(() => GetChannelRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<ChannelRepository>(() => ChannelRepoImpl(remoteDatasource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<GetChannel>(() => GetChannel(sl()));

  //Videos

  sl.registerLazySingleton<GetVideosRemoteDataSource>(() => GetVideosRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<GetVideosRepository>(() => GetVideosRepoImpl(networkInfo: sl(), remoteDatasource: sl()));

  sl.registerLazySingleton<GetVideos>(() => GetVideos(sl()));

  sl.registerLazySingleton<GetNextVideos>(() => GetNextVideos(sl()));

  sl.registerLazySingleton<HomeViewModel>(() => HomeViewModel(sl()));

  //Playlist

  sl.registerLazySingleton<PlaylistRemoteDataSource>(() => PlaylistRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<PlaylistRepository>(() => PlaylistRepoImpl(networkInfo: sl(), remoteDatasource: sl()));

  sl.registerLazySingleton<GetPlaylist>(() => GetPlaylist(sl()));

  //Playlist Videos

  sl.registerLazySingleton<GetPlaylistVideos>(() => GetPlaylistVideos(sl()));

  // Search
  sl.registerLazySingleton<SearchRemoteDatasource>(() => SearchRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<SearchLocalDataSource>(() => SearchLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl(), sl(),  sl()));

  sl.registerLazySingleton<GetSearchResults>(() => GetSearchResults(sl()));

  // Local

  sl.registerLazySingleton<GetLocalSearch>(() => GetLocalSearch(sl()));
  sl.registerLazySingleton<AddToSearch>(() => AddToSearch(sl()));

}