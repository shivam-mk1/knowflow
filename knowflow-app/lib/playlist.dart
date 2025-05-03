import 'package:flutter/material.dart';
import 'package:knowflow/utils/audioplayer.dart';

class PlaylistPage extends StatefulWidget {
  final String theme;
  final String add;
  const PlaylistPage({super.key, required this.theme, required this.add});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final Map<String, List<String>> themeTracks = {
    "Fitness": [
      "Strength Training Basics",
      "Nutrition for Muscle Gain",
      "Home Workouts without Equipment",
      "Cardio vs Weightlifting: What's Best?",
    ],
    "Technology": [
      "The Rise of 5G Networks",
      "Blockchain Beyond Bitcoin",
      "Future of Wearable Tech",
      "Cloud Computing Explained",
    ],
    "Outer Space": [
      "The James Webb Telescope Discoveries",
      "Life on Mars: Myth or Reality?",
      "Black Holes and Wormholes",
      "The Race for Space Tourism",
    ],
    "History": [
      "Ancient Civilizations: Egypt & Mesopotamia",
      "World War II: Key Turning Points",
      "The Renaissance Era Innovations",
      "Colonialism and Its Global Impact",
    ],
    "AI Today": [
      "ChatGPT and Generative AI",
      "AI in Healthcare Diagnostics",
      "Deepfakes and Digital Ethics",
      "Self-Driving Cars: Progress & Challenges",
    ],
    "Neuroscience": [
      "How Memory Works in the Brain",
      "The Science of Sleep",
      "Neuroplasticity: Brain's Adaptability",
      "Mental Health & Neurochemicals",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final tracks = themeTracks[widget.theme] ?? [];
    final double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Color(0xff0F0817),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  widget.theme,
                  style: TextStyle(color: Color(0xff0F0817), fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.5,

                child: Image(image: AssetImage(widget.add), fit: BoxFit.fill),
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                child: ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.audiotrack,
                          color: Color(0xff0F0817),
                        ),
                        title: Expanded(child: Text(tracks[index])),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Color(0xff0F0817),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Playing "${tracks[index]}"'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AudioPlayer(),
      ),
    );
  }
}
