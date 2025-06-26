function y = preprocess_audio(y, fs)
    if size(y, 2) == 2
        y = mean(y, 2);  % Stereo to mono
    end
    y = y - mean(y);     % Remove DC offset
    y = y / (max(abs(y)) + eps);  % Normalize amplitude
    y = trim_silence(y, fs);      % Trim silence
end

function y = trim_silence(y, fs)
    win = round(0.02 * fs);
    energy = buffer(y.^2, win, 0);
    frame_energy = sum(energy);
    threshold = 0.01 * max(frame_energy);
    voiced = find(frame_energy > threshold);

    if isempty(voiced)
        return;
    end

    start = max(1, (voiced(1)-1) * win + 1);
    stop = min(length(y), voiced(end) * win);
    y = y(start:stop);
end
