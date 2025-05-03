import 'package:flutter/material.dart';

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

    // TODO: Replace with real generation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Generating playlist for: ${_topics.join(', ')}')),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic-based Playlist Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _topicController,
                decoration: InputDecoration(
                  labelText: 'Add Topic',
                  hintText: 'e.g., Mindfulness, Focus, Sleep',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTopic,
                  ),
                ),
                onFieldSubmitted: (_) => _addTopic(),
              ),
              const SizedBox(height: 15),
              if (_topics.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  children: _topics.map((topic) {
                    return Chip(
                      label: Text(topic),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          _topics.remove(topic);
                        });
                      },
                    );
                  }).toList(),
                ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _generatePlaylist,
                icon: const Icon(Icons.playlist_add_check),
                label: const Text('Generate Playlist'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}