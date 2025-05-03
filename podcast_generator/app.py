from flask import Flask, render_template, request, send_file, redirect, url_for
import os
from podcast_generator import generate_podcast

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
    topic = request.form.get('topic')
    if not topic:
        return "No topic provided", 400

    try:
        script_path, audio_path = generate_podcast(topic)
        return render_template('result.html', topic=topic, script_path=script_path, audio_path=audio_path)
    except Exception as e:
        print(f"Error: {e}")
        return "Audio generation failed", 500

@app.route('/download/<filename>')
def download(filename):
    return send_file(os.path.join('output', filename), as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
