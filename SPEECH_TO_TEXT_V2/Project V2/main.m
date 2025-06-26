clear; clc;

load('templates.mat', 'templates', 'words');

[input_audio, fs] = audioread('audio/input.wav');
input_audio = preprocess_audio(input_audio, fs);
input_mfcc = normalize_features(extract_mfcc(input_audio, fs));

minDist = Inf;
matchedWord = 'Unknown';

for i = 1:length(words)
    for j = 1:length(templates{i})
        dist = dtw_distance(input_mfcc, templates{i}{j});
        fprintf('Distance to "%s" sample %d: %.2f\n', words{i}, j, dist);
        if dist < minDist
            minDist = dist;
            matchedWord = words{i};
        end
    end
end

fprintf('\n✅ Recognized word: %s (DTW Distance: %.2f)\n', matchedWord, minDist);
