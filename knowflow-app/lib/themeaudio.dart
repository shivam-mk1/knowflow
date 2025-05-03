import 'package:flutter/material.dart';
import 'package:knowflow/utils/audioplayer.dart';

class AudioPlaylistGeneratorPage extends StatefulWidget {
  const AudioPlaylistGeneratorPage({super.key});

  @override
  State<AudioPlaylistGeneratorPage> createState() =>
      _AudioPlaylistGeneratorPageState();
}

class _AudioPlaylistGeneratorPageState
    extends State<AudioPlaylistGeneratorPage> {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Generating playlist for "$theme" lasting $duration minutes',
          ),
        ),
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
                  "Curious? Start Here!",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _themeController,
                  decoration: InputDecoration(
                    labelText: 'Enter Theme',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'e.g., Space Exploration',
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
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter a theme'
                              : null,
                ),
                SizedBox(height: h * 0.03),
                DropdownButtonFormField<int>(
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Select Total Duration',
                    labelStyle: TextStyle(color: Colors.white),
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
                  ),
                  value: _selectedDuration,
                  dropdownColor: Color(0xff0F0817),
                  iconEnabledColor: Colors.white,
                  items:
                      durationOptions.entries
                          .map(
                            (entry) => DropdownMenuItem<int>(
                              value: entry.value,
                              child: Text(entry.key),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDuration = value;
                    });
                  },
                  validator:
                      (value) =>
                          value == null ? 'Please select a duration' : null,
                ),
                SizedBox(height: h * 0.03),
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
