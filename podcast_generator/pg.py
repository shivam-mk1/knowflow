import wikipedia
import logging
import os
import uuid
import re
import asyncio
import edge_tts

logging.basicConfig(level=logging.INFO, format='%(asctime)s - PodcastGenerator - %(levelname)s - %(message)s')

def fetch_wikipedia_summary(topic):
    try:
        search_results = wikipedia.search(topic)
        if not search_results:
            raise Exception(f"No Wikipedia results for topic: {topic}")
        for result in search_results:
            try:
                page = wikipedia.page(result)
                return page.content
            except:
                continue
        raise Exception("Failed to fetch a valid page.")
    except Exception as e:
        logging.error(f"Error fetching Wikipedia content: {e}")
        return ""

def clean_and_deduplicate(text):
    sentences = re.split(r'(?<=[.!?]) +', text)
    seen = set()
    unique_sentences = []
    for sentence in sentences:
        cleaned = sentence.strip()
        if cleaned and cleaned.lower() not in seen:
            unique_sentences.append(cleaned)
            seen.add(cleaned.lower())
    return unique_sentences

def summarize_text(sentences, word_limit=600):
    total_words = 0
    summary = []
    for sentence in sentences:
        word_count = len(sentence.split())
        if total_words + word_count <= word_limit:
            summary.append(sentence)
            total_words += word_count
        else:
            break
    return ' '.join(summary)

def add_intro_outro(topic, summary):
    intro = f"Welcome to today's podcast! We’ll be diving into the fascinating topic of {topic}. Let's get started.\n"
    outro = "\nThanks for listening! Stay tuned for more insightful episodes."
    return f"{intro}{summary}{outro}"

def generate_script(topic, output_dir="output"):
    content = fetch_wikipedia_summary(topic)
    if not content:
        return None
    sentences = clean_and_deduplicate(content)
    summarized = summarize_text(sentences, word_limit=600)
    final_script = add_intro_outro(topic, summarized)
    os.makedirs(output_dir, exist_ok=True)
    script_path = os.path.join(output_dir, f"{topic.replace(' ', '_').lower()}_script.txt")
    with open(script_path, "w", encoding="utf-8") as f:
        f.write(final_script)
    logging.info(f"Script saved to: {script_path}")
    return script_path

def read_script(script_path):
    try:
        with open(script_path, "r", encoding="utf-8") as f:
            return f.read()
    except Exception as e:
        logging.error(f"Error reading script file: {e}")
        return None

async def generate_audio_from_script(script_text, output_dir="output"):
    if not script_text:
        logging.error("Script is empty. Cannot generate audio.")
        return
    os.makedirs(output_dir, exist_ok=True)
    audio_filename = os.path.join(output_dir, f"podcast_{uuid.uuid4().hex[:6]}.mp3")
    try:
        communicate = edge_tts.Communicate(text=script_text, voice="en-US-GuyNeural")
        await communicate.save(audio_filename)
        logging.info(f"Audio saved to: {audio_filename}")
    except Exception as e:
        logging.error(f"Error generating audio: {e}")

def main():
    topic = input("Enter a topic for the podcast: ").strip()
    logging.info(f"Generating podcast for topic: {topic}")
    script_path = generate_script(topic)

    if script_path:
        script_text = read_script(script_path)
        asyncio.run(generate_audio_from_script(script_text))
    else:
        logging.error("Podcast generation failed due to script error.")

if __name__ == "__main__":
    main()
