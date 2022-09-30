import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/presentation/screens/playlist_info_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
        elevation: 0.0,
        // backgroundColor:
      )),
      home: const PlaylistInfoScreen(),
    );
  }
}



