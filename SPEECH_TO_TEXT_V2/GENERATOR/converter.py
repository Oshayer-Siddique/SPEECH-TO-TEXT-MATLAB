from gtts import gTTS
from pydub import AudioSegment
import os

# Words to generate
words = ['hello', 'yes', 'no', 'come']

# Simulated voices (male/female via accents)
voice_accents = {
    'US_Female': 'en',
    'UK_Female': 'en-uk',
    'Indian_Male': 'en-in',
    'Australian_Male': 'en-au'
}

# Output folder
output_folder = 'tts_output_wav'
os.makedirs(output_folder, exist_ok=True)

# Generate MP3 and convert to WAV
for word in words:
    for voice_label, lang in voice_accents.items():
        for i in range(1, 5):  # 4 variations per voice
            # Step 1: Generate MP3
            tts = gTTS(text=word, lang=lang, slow=False)
            mp3_path = f"{output_folder}/{word}_{voice_label}_v{i}.mp3"
            wav_path = mp3_path.replace('.mp3', '.wav')
            tts.save(mp3_path)

            # Step 2: Convert to WAV
            sound = AudioSegment.from_mp3(mp3_path)
            sound.export(wav_path, format="wav")

            # Optional: remove MP3 after conversion
            os.remove(mp3_path)

            print(f"Generated: {wav_path}")
