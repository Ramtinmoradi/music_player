import 'package:flutter/material.dart';
import 'package:my_player/data/playlist_provider.dart';
import 'package:provider/provider.dart';

import '/constants/theme.dart';
import 'screens/home_screen.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData,
      home: const HomeScreen(),
    );
  }
}
