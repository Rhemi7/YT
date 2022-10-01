import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youtube_data_api/features/data/datasources/get_channel_remote_datasource.dart';
import 'package:youtube_data_api/features/data/repository/get_channel_repo_impl.dart';
import 'package:youtube_data_api/features/domain/repository/get_channel_repository.dart';
import 'package:youtube_data_api/features/domain/usecase/get_channel.dart';
import 'package:youtube_data_api/features/presentation/view_model/home_view_model.dart';

import 'core/network_info.dart';




GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {

  //Http Client
  sl.registerLazySingleton(() => http.Client());


  //Data connection
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<GetChannelRemoteDataSource>(() => GetChannelRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<ChannelRepository>(() => ChannelRepoImpl(sl(), sl()));

  sl.registerLazySingleton<GetChannel>(() => GetChannel(sl()));

  sl.registerLazySingleton<HomeViewModel>(() => HomeViewModel(sl()));


}