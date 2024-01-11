import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'song_class.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<SongClass> _playlist = [
    SongClass(
      songName: 'Calm Down',
      artistName: 'Rema, Selena Gomez',
      albumArtImagePath: 'https://c.saavncdn.com/596/Calm-Down-English-2022-20220826054039-500x500.jpg',
      songPath: 'https://aac.saavncdn.com/596/0044bdbc00972a8496e65a68b1444597_320.mp4',
      songDuration: '239',
    ),
    SongClass(
      songName: 'We Don\'t Talk Anymore',
      artistName: 'Charlie Puth & Selena Gomez',
      albumArtImagePath: 'https://c.saavncdn.com/850/Nine-Track-Mind-English-2016-20190607044034-500x500.jpg',
      songPath: 'https://aac.saavncdn.com/850/628a6629691b4c030d6df52d0cbd3e5c_320.mp4',
      songDuration: '217',
    ),
    SongClass(
      songName: 'Taki Taki',
      artistName: 'DJ Snake & Selena Gomez',
      albumArtImagePath: 'https://c.saavncdn.com/341/Carte-Blanche-English-2019-20190917204015-500x500.jpg',
      songPath: 'https://aac.saavncdn.com/341/e7cc8c159cd4ec52c6684a901b5eabf7_320.mp4',
      songDuration: '213',
    ),
  ];

  int? _currentSongIndex;
  bool? _isLike;

  //Getter
  List<SongClass> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //Setter
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].songPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
}
