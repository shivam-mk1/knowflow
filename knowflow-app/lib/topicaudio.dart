import 'package:flutter/material.dart';
import 'package:knowflow/utils/audioplayer.dart';
import 'package:knowflow/utils/toast.dart';

class TopicBasedPlaylistGeneratorPage extends StatefulWidget {
  const TopicBasedPlaylistGeneratorPage({super.key});

  @override
  State<TopicBasedPlaylistGeneratorPage> createState() =>
      _TopicBasedPlaylistGeneratorPageState();
}

class _TopicBasedPlaylistGeneratorPageState
    extends State<TopicBasedPlaylistGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _topicController = TextEditingController();

  final List<String> _topics = [];

  void _addTopic() {
    final topic = _topicController.text.trim();
    if (topic.isNotEmpty && !_topics.contains(topic)) {
      setState(() {
        _topics.add(topic);
        _topicController.clear();
      });
    }
  }

  void _generatePlaylist() {
    if (_topics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one topic')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Generating playlist for: ${_topics.join(', ')}')),
    );
    try {
      
    } catch (e) {
      ToastWidget("Error : $e", 0);
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Color(0xff0F0817),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
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
                  "Whats on your mind today?",
                  style: TextStyle(color: Color(0xff0F0817), fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _topicController,
                  decoration: InputDecoration(
                    labelText: 'Add Topic',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'e.g., Mindfulness, Focus, Sleep',
                    hintStyle: TextStyle(color: Colors.white30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _addTopic,
                    ),
                  ),
                  onFieldSubmitted: (_) => _addTopic(),
                ),
                const SizedBox(height: 15),
                if (_topics.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    children:
                        _topics.map((topic) {
                          return Chip(
                            label: Text(
                              topic,
                              style: TextStyle(color: Color(0xff0F0817)),
                            ),
                            deleteIcon: const Icon(
                              Icons.close,
                              color: Color(0xff0F0817),
                            ),
                            onDeleted: () {
                              setState(() {
                                _topics.remove(topic);
                              });
                            },
                          );
                        }).toList(),
                  ),

                SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: _generatePlaylist,
                    icon: const Icon(
                      Icons.playlist_add_check,
                      color: Color(0xff0F0817),
                      size: 24,
                    ),
                    label: const Text(
                      'Generate Playlist',
                      style: TextStyle(color: Color(0xff0F0817), fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AudioPlayer(),
      ),
    );
  }
}
