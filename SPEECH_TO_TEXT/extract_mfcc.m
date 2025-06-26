function mfcc_feat = extract_mfcc(signal, fs)
    % If stereo, convert to mono
    if size(signal, 2) == 2
        signal = mean(signal, 2);  % average left and right channels
    end

    mfcc_feat = mfcc(signal, fs, 'LogEnergy', 'Ignore');  % [timeSteps x features]
end
