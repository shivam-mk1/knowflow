**KnowFlow - Personalized 5-Minute Learning Snippet Generator**
KnowFlow is a Flutter-based mobile application developed for the Global MIT AI Hackathon (May 2-3, 2025) under the "Spotify for Learning" track. It transforms idle time—commutes, workouts, or breaks—into meaningful learning sessions by delivering personalized, 5-minute, podcast-style audio snippets. Using Wikipedia content and Microsoft Edge TTS, KnowFlow curates engaging, curiosity-driven audio playlists tailored to user interests, making micro-learning accessible and delightful.
Introduction
The rise of micro-learning has created opportunities for bite-sized knowledge delivery, especially through audio formats given the surge in mobile usage. KnowFlow is an intelligent, curiosity-driven tool that turns short pockets of time into engaging learning experiences. By fetching structured content from Wikipedia and converting it into realistic audio with Edge TTS, KnowFlow delivers informative snippets that mimic human-hosted podcasts.
Features

Personalized Learning Snippets: Input specific topics (e.g., "The founding story of the United Nations") to generate 5-minute, voice-ready audio explanations sourced from Wikipedia.
Theme-Based Audio Generation: Explore curated themes like "Lost Civilizations," "Future of Food," "Climate Change," "Artificial Intelligence," and "Space Exploration" with a single tap, ideal for first-time users.
Seamless Playlist Creation: Build and play audio playlists with a Spotify-inspired UI, supporting background playback for uninterrupted learning.
Curiosity-Driven Suggestions: Start with suggested themes to spark new learning journeys, with plans for dynamic recommendations based on user preferences.
One-Step User Interface: Go from topic input to playable audio in one step, with an intuitive, mobile-optimized Flutter design.
Downloadable Content: Save audio snippets and scripts for offline access.

System Architecture
KnowFlow’s modular architecture consists of three core components:

Backend Content Pipeline:

Prompt Understanding: User inputs are processed as topics (e.g., "AI avatars") and used to query Wikipedia’s API for relevant content.
Content Generation: A Python script (podcast_generator.py) fetches Wikipedia summaries, cleans and deduplicates sentences, and summarizes them to a 600-word limit. An intro and outro are added to create a podcast-style script.
Backend Server: A Flask server (app.py) handles topic requests, orchestrates content generation, and serves audio/script files to the frontend.


Text-to-Speech Engine: Microsoft Edge TTS (edge_tts) converts generated scripts into audio using the en-US-GuyNeural voice, producing MP3 files with natural narration.

User-Facing Frontend: A Flutter-based mobile interface (knowflow-app) provides a seamless experience for inputting topics, generating playlists, playing audio, and downloading content.


Tech Stack

Frontend: Flutter (Dart) for a cross-platform, responsive UI.
Backend: Flask (Python) for handling topic requests and file serving.
Content Generation: wikipedia Python library for fetching and summarizing content.
Text-to-Speech: edge_tts for generating podcast-style audio.
Audio Playback: just_audio and just_audio_background for streaming and background audio.
State Management: Provider for lightweight state management.
API Requests: http package for frontend-backend communication.
Additional Libraries: uuid, re, asyncio, logging for backend processing.

Prerequisites

Frontend:

Flutter SDK (version 3.24 or higher)
Dart (version 3.5 or higher)
Android Studio or VS Code with Flutter plugins
A device or emulator (iOS/Android) for testing


Backend:

Python 3.8+
Flask, wikipedia, edge-tts, and other dependencies (listed in podcast_generator/requirements.txt)
A working internet connection for Wikipedia API access



Setup Instructions

Clone the Repository:
git clone https://github.com/your-team/knowflow.git
cd knowflow_app


Set Up the Backend:

Navigate to the backend directory:
cd podcast_generator


Create and activate a virtual environment (optional but recommended):
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate


Install dependencies:
pip install -r requirements.txt


Example requirements.txt:
flask==2.3.3
wikipedia==1.4.0
edge-tts==6.1.12


Start the Flask server:
python app.py


The server will run on http://localhost:5000 by default.



Set Up the Frontend:

Navigate to the frontend directory:
cd ../knowflow-app


Install dependencies:
flutter pub get


Ensure pubspec.yaml includes:
dependencies:
  flutter:
    sdk: flutter
  just_audio: ^0.9.40
  http: ^1.2.1
  provider: ^6.0.0




Run the App:

Ensure the Flask server is running.

Run the Flutter app:
flutter run


Update the frontend to point to the backend URL (e.g., http://localhost:5000) in your HTTP requests (e.g., in api_service.dart).



Test the App:

Open the app, select a suggested theme (e.g., "Space Exploration"), or enter a custom topic.
Generate a playlist, play audio snippets, and download scripts or audio files.
Verify audio playback and file downloads work seamlessly.



Project Structure
knowflow/
├── knowflow-app/                # Flutter frontend
│   ├── android/                 # Android-specific files
│   ├── assets/                  # Assets (e.g., images, fonts)
│   ├── ios/                     # iOS-specific files
│   ├── lib/                     # Dart source code
│   ├── pubspec.lock             # Dependency lock file
│   ├── pubspec.yaml             # Frontend dependencies and configuration
│   └── README.md                # Frontend-specific README (if any)
├── podcast_generator/           # Backend for content and audio generation
│   ├── app.py                   # Flask server
│   ├── deploy_script.txt        # Deployment script (if any)
│   ├── pg.py                    # Likely a backup or test script
│   ├── podcast_233f9d.mp3       # Sample generated audio file
│   ├── podcast_generator.py     # Main script for Wikipedia fetching and TTS
│   ├── requirements.txt         # Backend dependencies
│   └── requirements.txt.txt     # Duplicate requirements file
└── README.md                    # Project documentation

Usage

First-Time Experience:

On launch, users see suggested themes like "Fitness", "Technology", "AI Today", "History", "Neuroscience" and "Space Exploration".
Tap a theme or enter a custom topic (e.g., "World History") to generate a podcast.


Generate Snippets:

Click "Explore a Theme!" to fetch a Wikipedia-based script and generate a 5-minute audio snippet using Edge TTS.
Download the script or audio file for offline use.


Play and Explore:

View the generated playlist in a scrollable list.
Play snippets with background audio support using just_audio.



Hackathon Alignment
KnowFlow addresses the "Spotify for Learning" challenge by:

Content Quality & Clarity: Uses Wikipedia’s reliable content, summarized and structured with intro/outro for engaging, podcast-style snippets.
Seamless User Experience: Offers a one-step topic-to-play flow with a clean, intuitive Flutter UI.
Depth of Personalization: Supports user-defined topics and curated themes, with plans for preference-based recommendations.
Curiosity Recommendations: Provides suggested themes to spark user interest.
Audio Delivery: Delivers natural audio via Edge TTS, optimized for mobile listening.

Team

Shivam, Abhrajit Ghosh - Frontend Developer (Flutter UI, audio playback)
Alankrit Raj, Trijoy Sinha - Backend Developer (Flask, Wikipedia, Edge TTS integration)

Acknowledgments

MIT AI Hackathon organizers: Shreeansh Agawal, Linn Bieske, Andrea Jimenez, Kai Wiederhold, Lisa Sklyarova.
Wikipedia for providing open-access content.
Microsoft for Edge TTS.
Flutter community for robust packages like just_audio and http.

