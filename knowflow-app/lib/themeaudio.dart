import 'package:flutter/material.dart';

class AudioPlaylistGeneratorPage extends StatefulWidget {
  const AudioPlaylistGeneratorPage({super.key});

  @override
  State<AudioPlaylistGeneratorPage> createState() => _AudioPlaylistGeneratorPageState();
}

class _AudioPlaylistGeneratorPageState extends State<AudioPlaylistGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _themeController = TextEditingController();

  int? _selectedDuration;

  final Map<String, int> durationOptions = {
    '5 minutes': 5,
    '10 minutes': 10,
    '15 minutes': 15,
    '30 minutes': 30,
    '45 minutes': 45,
    '1 hour': 60,
  };

  void _generatePlaylist() {
    if (_formKey.currentState!.validate()) {
      String theme = _themeController.text;
      int duration = _selectedDuration!;

      // TODO: Replace with actual playlist generation logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Generating playlist for "$theme" lasting $duration minutes')),
      );
    }
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Playlist Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _themeController,
                decoration: const InputDecoration(
                  labelText: 'Enter Theme',
                  hintText: 'e.g., Space Exploration',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a theme' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Select Total Duration',
                  border: OutlineInputBorder(),
                ),
                value: _selectedDuration,
                items: durationOptions.entries
                    .map((entry) => DropdownMenuItem<int>(
                          value: entry.value,
                          child: Text(entry.key),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDuration = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a duration' : null,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _generatePlaylist,
                  icon: const Icon(Icons.playlist_add),
                  label: const Text('Generate Playlist'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}