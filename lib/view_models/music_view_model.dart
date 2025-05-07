import 'dart:async' show StreamSubscription;
import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:axtune/model/music_model.dart';
import 'package:axtune/utils/permission_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final musicPaths = [
  {
    "title": "Accept The Challenge",
    "artist": "MaxKoMusic",
    "duration": "02:39",
    "musicPath": "assets/musics/Accept-The-Challenge-chosic.com_.mp3",
    "url": "https://www.chosic.com/download-audio/59090/",
    "credits": '''Accept The Challenge by MaxKoMusic | https://maxkomusic.com/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY-SA 3.0
https://creativecommons.org/licenses/by-sa/3.0/''',
  },
  {
    "title": "Dragon Castle",
    "artist": "Makai Symphony",
    "duration": "02:41",
    "musicPath": "assets/musics/Dragon-Castle(chosic.com).mp3",
    "url": "https://www.chosic.com/download-audio/29545/",
    "credits":
        '''Dragon Castle by Makai Symphony | https://soundcloud.com/makai-symphony
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY-SA 3.0
https://creativecommons.org/licenses/by-sa/3.0/''',
  },
  {
    "title": "Powerful Trap Beat | Strong",
    "artist": "Alex-Productions",
    "duration": "02:00",
    "musicPath": "assets/musics/Powerful-Trap-(chosic.com).mp3",
    "url": "https://www.chosic.com/download-audio/31959/",
    "credits":
        '''Powerful Trap Beat | Strong by Alex-Productions | https://onsound.eu/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY 3.0
https://creativecommons.org/licenses/by/3.0/''',
  },
  {
    "title": "Perfection",
    "artist": "MaxKoMusic",
    "duration": "02:55",
    "musicPath": "assets/musics/Perfection(chosic.com).mp3",
    "url": "https://www.chosic.com/download-audio/45442/",
    "credits": '''Perfection by MaxKoMusic | https://maxkomusic.com/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY-SA 3.0
https://creativecommons.org/licenses/by-sa/3.0/''',
  },
  {
    "title": "Daylight",
    "artist": "Alex-Productions",
    "duration": "02:14",
    "musicPath": "assets/musics/Daylight-chosic.com_.mp3",
    "url": "https://www.chosic.com/download-audio/59019/",
    "credits": '''Daylight by Alex-Productions | https://onsound.eu/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY 3.0
https://creativecommons.org/licenses/by/3.0/''',
  },
];

class MusicViewModel extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final PermissionManager _permissionsState = PermissionManager();
  ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: []);
  int _currentIndex = 0;
  final Duration _skipTime = Duration(seconds: 10);
  List<MusicModel> musics = [];
  StreamSubscription? _durationSub;
  StreamSubscription? _playerStateSub;
  StreamSubscription? _positionSub;

  int get currentIndex => _currentIndex;

  ({Duration inDuration, double inDouble, String inString}) get position {
    final position = _player.position;
    return (
      inDuration: position,
      inDouble: position.inMilliseconds.toDouble(),
      inString: _formatDuration(duration: position),
    );
  }

  ({Duration inDuration, double inDouble, String inString}) get duration {
    final duration = _player.duration ?? Duration.zero;
    return (
      inDuration: duration,
      inDouble: duration.inMilliseconds.toDouble(),
      inString: _formatDuration(duration: duration),
    );
  }

  String get remaining =>
      _formatDuration(duration: duration.inDuration - position.inDuration);
  double get sliderValue {
    final sliderValue = position.inDouble / duration.inDouble;
    return (sliderValue.isNaN || sliderValue > 1) ? 0 : sliderValue;
  }

  bool get isPlaying => _player.playing;
  MediaItem? get currentMedia =>
      _player.sequenceState?.currentSource?.tag as MediaItem?;

  Future<List<MusicModel>> loadMusics(BuildContext context) async {
    await _permissionsState.ensureAllPermissionsGranted(context);

    if (!_permissionsState.storagePermissionStatus.isGranted &&
        !_permissionsState.audioPermissionStatus.isGranted &&
        !_permissionsState.videosPermissionStatus.isGranted &&
        !_permissionsState.photosPermissionStatus.isGranted) {
      return [];
    }
    final songs = await _audioQuery.querySongs();
    for (var song in songs) {
      musics.add(
        MusicModel(
          duration: _formatDuration(milliseconds: song.duration),
          artist: song.artist ?? '',
          credits: '''Royalty Free Music: https://www.bensound.com
     License code: WGHX4RGOTU7PKK4E''',
          musicPath: song.uri ?? '',
          title: song.title,
          url:
              'https://www.bensound.com/royalty-free-music/track/slow-life-intriguing-epic',
          type: MusicType.uri,
        ),
      );
    }
    for (var music in musicPaths) {
      musics.add(MusicModel.fromJson(music));
    }
    playlist = ConcatenatingAudioSource(
      children:
          musics.map((music) {
            switch (music.type) {
              case MusicType.asset:
                return AudioSource.asset(
                  music.musicPath,
                  tag: MediaItem(
                    id: music.musicPath,
                    title: music.title,
                    artist: music.artist,
                    extras: {
                      'duration': music.duration,
                      'url': music.url,
                      'credits': music.credits,
                    },
                  ),
                );
              case MusicType.file:
                return AudioSource.file(
                  music.musicPath,
                  tag: MediaItem(
                    id: music.musicPath,
                    title: music.title,
                    artist: music.artist,
                    extras: {
                      'duration': music.duration,
                      'url': music.url,
                      'credits': music.credits,
                    },
                  ),
                );

              case MusicType.uri:
                return AudioSource.uri(
                  Uri.parse(music.musicPath),
                  tag: MediaItem(
                    id: music.musicPath,
                    title: music.title,
                    artist: music.artist,
                    extras: {
                      'duration': music.duration,
                      'url': music.url,
                      'credits': music.credits,
                    },
                  ),
                );
            }
          }).toList(),
    );
    return musics;
  }

  Future<void> initializeMusic(int index) async {
    _currentIndex = index;

    await _player.setAudioSource(playlist, initialIndex: _currentIndex);

    initPlayerValues();
    _player.play();

    notifyListeners();
  }

  void initPlayerValues() {
    _positionSub = _player.positionStream.listen((_) => notifyListeners());
    _playerStateSub = _player.playerStateStream.listen((state) {
      if (_currentIndex == musics.length - 1 &&
          state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero, index: 0);
        _currentIndex = 0;
        playPauseMusic();
        notifyListeners();
      }

      notifyListeners();
    });
    _durationSub = _player.durationStream.listen((duration) {
      if (duration != null) {
        notifyListeners();
        _durationSub?.cancel();
      }
    });
  }

  void seekTo(double position) {
    if (position >= 0 && position <= 1) {
      final seekPosition = (position * duration.inDouble).toInt();
      _player.seek(Duration(milliseconds: seekPosition));
      notifyListeners();
    }
  }

  void playPauseMusic() {
    isPlaying ? _player.pause() : _player.play();
    notifyListeners();
  }

  void replay() {
    final newPosition = position.inDuration - _skipTime;
    _player.seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
    notifyListeners();
  }

  void forward() {
    final newPosition = position.inDuration + _skipTime;
    _player.seek(
      newPosition <= duration.inDuration ? newPosition : duration.inDuration,
    );
    notifyListeners();
  }

  void skipNext() {
    if (_currentIndex < musics.length - 1) {
      _currentIndex++;
      switchMusic();
    }
  }

  void skipPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      switchMusic();
    }
  }

  void switchMusic() {
    _player.seek(Duration.zero, index: _currentIndex);
    notifyListeners();
  }

  void back() {
    _player.pause();
    notifyListeners();
  }

  String _formatDuration({int? milliseconds, Duration? duration}) {
    if (milliseconds == null && duration == null) duration = Duration.zero;

    duration = duration ?? Duration(milliseconds: milliseconds ?? 0);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _player.dispose();
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    _durationSub?.cancel();
    super.dispose();
  }
}
