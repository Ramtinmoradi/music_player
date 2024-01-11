class SongClass {
  final String songName;
  final String artistName;
  final String albumArtImagePath;
  final String songPath;
  final String songDuration;

  SongClass({
    required this.songName,
    required this.artistName,
    required this.albumArtImagePath,
    required this.songPath,
    required this.songDuration,
  });

  factory SongClass.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return SongClass(
      songName: jsonMapObject['title'],
      artistName: jsonMapObject['primaryArtists'],
      albumArtImagePath: jsonMapObject['image'][2]['link'],
      songPath: jsonMapObject['downloadUrl'][4]['link'],
      songDuration: jsonMapObject['duration'],
    );
  }
}
