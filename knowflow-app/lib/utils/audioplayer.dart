import 'package:flutter/material.dart';
import 'package:knowflow/provider/floatingcardprovider.dart';
import 'package:provider/provider.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerProvider>(context);
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        right: w * 0.02,
        left: w * 0.02,
        bottom: h * 0.02,
      ),
      child: Container(
        height: h * 0.17,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.white38)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      player.currentAudio,
                      style: const TextStyle(
                        color: Color(0xff0F0817),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.4),
                  IconButton(
                    onPressed: () {
                      player.playPrevious(
                        'assets/audio/example.mp3',
                        title: 'Previous Song',
                      );
                    },
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      color: Color(0xff0F0817),
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.togglePlayPause();
                    },
                    icon: Icon(
                      player.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: const Color(0xff0F0817),
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.playNext(
                        'assets/audio/example.mp3',
                        title: 'Next Song',
                      );
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Color(0xff0F0817),
                      size: 30,
                    ),
                  ),
                ],
              ),
              // Progress bar and duration display
              Row(
                children: [
                  Text(
                    _formatDuration(player.position),
                    style: const TextStyle(color: Color(0xff0F0817)),
                  ),
                  Expanded(
                    child: Slider(
                      value: player.position.inSeconds.toDouble().clamp(
                        0.0,
                        player.duration.inSeconds.toDouble(),
                      ),
                      max:
                          player.duration.inSeconds.toDouble() > 0
                              ? player.duration.inSeconds.toDouble()
                              : 1.0,
                      onChanged: (value) async {
                        await player.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: const Color(0xff0F0817),
                      inactiveColor: Colors.grey[300],
                    ),
                  ),
                  Text(
                    _formatDuration(player.duration),
                    style: const TextStyle(color: Color(0xff0F0817)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to format duration as MM:SS
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
