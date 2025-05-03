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
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white38)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  player.currentAudio,
                  style: TextStyle(
                    color: Color(0xff0F0817),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: w * 0.4),
              IconButton(
                onPressed: () {},
                icon: Icon(
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
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  color: Color(0xff0F0817),
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: Color(0xff0F0817),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
