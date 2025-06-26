% Create multiple templates per word (e.g., yes_1.wav, yes_2.wav)
clear; clc;

template_files = {
    'yes_1.wav', 'yes_2.wav';
    'no_1.wav', 'no_2.wav'
};

labels = {'yes', 'no'};

templates = cell(size(labels));
words = labels;

for i = 1:length(labels)
    samples = template_files(i, :);
    mfcc_list = {};
    for j = 1:length(samples)
        [audio, fs] = audioread(fullfile('audio', samples{j}));
        audio = preprocess_audio(audio, fs);
        mfcc = extract_mfcc(audio, fs);
        mfcc = normalize_features(mfcc);
        mfcc_list{end+1} = mfcc;
        fprintf('Processed: %s\n', samples{j});
    end
    templates{i} = mfcc_list;
end

save('templates.mat', 'templates', 'words');
disp('Templates saved.');
