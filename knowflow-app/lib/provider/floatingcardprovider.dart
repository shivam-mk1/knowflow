import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:knowflow/utils/toast.dart';

class PlayerProvider extends ChangeNotifier {
  String currentAudio = 'None playing';
  final _player = AudioPlayer();
  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  PlayerProvider() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      notifyListeners();
    });

    _player.positionStream.listen((pos) {
      position = pos;
      notifyListeners();
    });

    _player.durationStream.listen((dur) {
      duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  Future<void> setAudio(String assetPath, {String title = "Unknown"}) async {
    currentAudio = title;
    try {
      duration = Duration.zero;
      position = Duration.zero;
      notifyListeners();
      await _player.setAsset(assetPath);
      final audioDuration = _player.duration;
      if (audioDuration != null) {
        duration = audioDuration;
        notifyListeners();
      }
    } catch (e) {
      ToastWidget('Error setting audio: $e', 0).showToast();
    }
  }

  Future<void> playNext(String assetPath, {String title = "Next"}) async {
    await setAudio(assetPath, title: title);
    await _player.play();
  }

  Future<void> playPrevious(
    String assetPath, {
    String title = "Previous",
  }) async {
    await setAudio(assetPath, title: title);
    await _player.play();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
      this.position = position;
      notifyListeners();
    } catch (e) {
      print('Error seeking: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
