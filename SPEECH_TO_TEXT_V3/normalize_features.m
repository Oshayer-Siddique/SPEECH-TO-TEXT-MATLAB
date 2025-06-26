function mfcc_norm = normalize_features(mfcc)
    mu = mean(mfcc, 1);
    sigma = std(mfcc, 0, 1) + eps;
    mfcc_norm = (mfcc - mu) ./ sigma;
end
