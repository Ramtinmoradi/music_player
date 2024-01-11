import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_player/data/playlist_provider.dart';
import 'package:my_player/widgets/song_cover_box.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String twoDigitMinute = duration.inMinutes.toString().padLeft(2, '0');
    String formatTime = '$twoDigitMinute:$twoDigitSeconds';

    return formatTime;
  }

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;

        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_downward,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.background,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Player'.toUpperCase(),
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
              child: Column(
                children: <Widget>[
                  ContainerNeon(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            child: CachedNetworkImage(
                              imageUrl: currentSong.albumArtImagePath,
                              height: 350.0,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            currentSong.songName,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary,
                              letterSpacing: 2.0,
                            ),
                          ),
                          subtitle: Text(
                            currentSong.artistName,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary,
                              letterSpacing: 1.0,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              if (isLike) {
                                setState(() {
                                  isLike = false;
                                });
                              } else {
                                setState(() {
                                  isLike = true;
                                });
                              }
                            },
                            icon: Icon(
                              isLike ? Icons.favorite : Icons.favorite_border,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Text>[
                            Text(
                              formatTime(value.currentDuration),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onPrimary,
                                letterSpacing: 2.0,
                              ),
                            ),
                            Text(
                              formatTime(value.totalDuration),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onPrimary,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 1.5,
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
                          thumbColor: Theme.of(context).colorScheme.primary,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                        ),
                        child: Slider(
                          value: value.currentDuration.inSeconds.toDouble(),
                          min: 0.0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          onChanged: (value) {},
                          onChangeEnd: (endValue) {
                            setState(() {
                              value.seek(Duration(seconds: endValue.toInt()));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ContainerNeon(
                          child: Center(
                            child: IconButton(
                              onPressed: value.playPreviousSong,
                              icon: Icon(
                                Icons.skip_previous,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 4,
                        child: ContainerNeon(
                          child: Center(
                            child: IconButton(
                              onPressed: value.pauseOrResume,
                              icon: Icon(
                                value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: ContainerNeon(
                          child: Center(
                            child: IconButton(
                              onPressed: value.playNextSong,
                              icon: Icon(
                                Icons.skip_next,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
