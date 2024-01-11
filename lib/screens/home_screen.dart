import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_player/data/playlist_provider.dart';
import 'package:my_player/data/song_class.dart';
import 'package:my_player/screens/player_screen.dart';
import 'package:provider/provider.dart';

import '/widgets/song_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();

    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlayerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Song List'.toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PlaylistProvider>(
            builder: (context, value, child) {
              final List<SongClass> playlist = value.playlist;

              return ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final SongClass song = playlist[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ListTile(
                      onTap: () => goToSong(index),
                      tileColor: Theme.of(context).colorScheme.onBackground,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      title: Text(
                        song.songName,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                          letterSpacing: 2.0,
                        ),
                      ),
                      subtitle: Text(
                        song.artistName,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                          letterSpacing: 2.0,
                        ),
                      ),
                      trailing: CachedNetworkImage(
                        width: 60.0,
                        height: 60.0,
                        imageUrl: song.albumArtImagePath,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
