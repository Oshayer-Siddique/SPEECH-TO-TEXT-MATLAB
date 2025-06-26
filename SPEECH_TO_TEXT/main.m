clear; clc;

[train_audio, fs] = audioread('yes.wav');
train_mfcc = extract_mfcc(train_audio, fs);

[test_audio, fs] = audioread('input.wav');
test_mfcc = extract_mfcc(test_audio, fs);

disp(['train_mfcc size: ', mat2str(size(train_mfcc))]);
disp(['test_mfcc size: ', mat2str(size(test_mfcc))]);

dist = dtw_distance(test_mfcc, train_mfcc);

fprintf('Distance to "yes": %.4f\n', dist);

threshold = 100; % adjust as needed
if dist < threshold
    fprintf('Recognized word: yes\n');
else
    fprintf('Word not recognized\n');
end
