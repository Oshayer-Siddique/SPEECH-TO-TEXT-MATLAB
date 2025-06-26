function mfcc_feat = extract_mfcc(signal, fs)
    mfcc_feat = mfcc(signal, fs, 'LogEnergy', 'Ignore'); % [timeSteps x features]
end
