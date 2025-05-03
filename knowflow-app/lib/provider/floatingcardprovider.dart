import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  String currentAudio = 'None playing';
  bool isPlaying = false;

  void play(String current) {
    currentAudio = current;
    isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    isPlaying = !isPlaying;
    notifyListeners();
  }
}
