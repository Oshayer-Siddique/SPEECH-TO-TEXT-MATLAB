from gtts import gTTS
import os

# Word mapping (filename: actual Bangla text to say)
word_map = {
    'ashun_1': 'আসুন',
    'ashun_2': 'আসুন',
    'ha_1': 'হ্যাঁ',
    'ha_2': 'হ্যাঁ',
    'na_1': 'না',
    'na_2': 'না',
    'biday_1': 'বিদায়',
    'biday_2': 'বিদায়',
    'bondho_1': 'বন্ধ',
    'bondho': 'বন্ধ',
}

# Output directory
output_dir = 'bangla_mp3'
os.makedirs(output_dir, exist_ok=True)

# Generate MP3 files
for filename, bangla_text in word_map.items():
    tts = gTTS(text=bangla_text, lang='bn')
    mp3_path = os.path.join(output_dir, f"{filename}.mp3")
    tts.save(mp3_path)
    print(f"Generated: {mp3_path}")
