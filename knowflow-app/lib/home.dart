import 'package:flutter/material.dart';
import 'package:knowflow/playlist.dart';
import 'package:knowflow/themeaudio.dart';
import 'package:knowflow/topicaudio.dart';
import 'package:knowflow/utils/audioplayer.dart';
import 'package:knowflow/utils/transitions.dart';
import 'package:marquee/marquee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List images = [
    "assets/images/fitness.jpg",
    "assets/images/tech.jpg",
    "assets/images/space.jpg",
    "assets/images/history.jpg",
    "assets/images/ai.jpg",
    "assets/images/neuro.jpg",
  ];

  Map<String, List<String>> data = {
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

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
                  "KnowFlow",
                  style: TextStyle(color: Color(0xff0F0817), fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xff0F0817),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      height: h * 0.06,
                      width: w * 0.43,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Marquee(
                                text: "Craft Your 5-Min Playlist",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                velocity: 50,
                                blankSpace: 30,
                                pauseAfterRound: Duration(seconds: 1),
                                showFadingOnlyWhenScrolling: true,
                                fadingEdgeStartFraction: 0.1,
                                fadingEdgeEndFraction: 0.1,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(_animation.value, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        SlideTransitionRoute(
                                          page:
                                              TopicBasedPlaylistGeneratorPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  InkWell(
                    child: Container(
                      height: h * 0.06,
                      width: w * 0.43,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Marquee(
                                text: "Curate Your Theme",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                velocity: 50,
                                blankSpace: 30,
                                pauseAfterRound: Duration(seconds: 1),
                                showFadingOnlyWhenScrolling: true,
                                fadingEdgeStartFraction: 0.1,
                                fadingEdgeEndFraction: 0.1,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(_animation.value, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        SlideTransitionRoute(
                                          page: AudioPlaylistGeneratorPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Popular playlists",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return buildItem(index);
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

  Widget buildItem(int index) {
    List<String> keys = data.keys.toList();
    final double h = MediaQuery.of(context).size.height;
    // final double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          SlideTransitionRoute(
            page: PlaylistPage(theme: keys[index], add: images[index]),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: h * 0.16,

            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(keys[index], style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
