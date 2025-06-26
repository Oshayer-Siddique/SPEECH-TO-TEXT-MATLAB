from gtts import gTTS
import os

# Words to generate
words = ['hello', 'yes', 'no', 'come']

# Simulated male/female voices using regional accents
voice_accents = {
    'US_Female': 'en',
    'UK_Female': 'en-uk',
    'Indian_Male': 'en-in',
    'Australian_Male': 'en-au'
}

# Output folder
output_folder = 'tts_output'
os.makedirs(output_folder, exist_ok=True)

# Generate MP3s
for word in words:
    for voice_label, lang in voice_accents.items():
        for i in range(1, 5):  # Create 4 variations per word
            tts = gTTS(text=word, lang=lang, slow=False)
            filename = f"{output_folder}/{word}_{voice_label}_v{i}.mp3"
            tts.save(filename)
            print(f"Generated: {filename}")
