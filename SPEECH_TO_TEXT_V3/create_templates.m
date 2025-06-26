clear; clc;

template_files = {
    'audio/ashun_1.wav', 'audio/ashun_2.wav';
    'audio/ha_1.wav', 'audio/ha_2.wav';
    'audio/na_1.wav', 'audio/na_2.wav';
    'audio/biday_1.wav', 'audio/biday_2.wav';
    'audio/bondho_1.wav', 'audio/bondho_2.wav'
};

labels = {'ashun', 'ha', 'na', 'biday', 'bondho'};

templates = cell(size(labels));
words = labels;

for i = 1:length(labels)
    samples = template_files(i, :);
    mfcc_list = {};
    for j = 1:length(samples)
        [audio, fs] = audioread(samples{j});
        audio = preprocess_audio(audio, fs);
        mfcc = extract_mfcc(audio, fs);
        mfcc = normalize_features(mfcc);
        mfcc_list{end+1} = mfcc;
        fprintf('Processed: %s\n', samples{j});
    end
    templates{i} = mfcc_list;
end

save('templates.mat', 'templates', 'words');
disp('✅ Templates saved.');
