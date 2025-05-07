enum MusicType { asset, file, uri }

class MusicModel {
  final String? duration;
  final String artist;
  final String credits;
  final String musicPath;
  final String title;
  final String url;
  final MusicType type;
  final String? thumbnail;

  MusicModel({
    required this.type,
    required this.artist,
    required this.credits,
    required this.musicPath,
    required this.title,
    required this.url,
    this.duration,
    this.thumbnail,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      duration: json["duration"],
      artist: json["artist"],
      credits: json["credits"],
      musicPath: json["musicPath"],
      title: json["title"],
      url: json["url"],
      type: MusicType.asset,
    );
  }
}
