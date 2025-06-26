function dist = dtw_distance(mfcc1, mfcc2)
    % Compute pairwise distances (timeSteps1 x timeSteps2)
    D = pdist2(mfcc1, mfcc2, 'euclidean');
    
    % Dynamic programming
    [n, m] = size(D);
    DTW = zeros(n+1, m+1) + Inf;
    DTW(1,1) = 0;
    
    for i = 2:n+1
        for j = 2:m+1
            cost = D(i-1, j-1);
            DTW(i, j) = cost + min([DTW(i-1, j), DTW(i, j-1), DTW(i-1, j-1)]);
        end
    end
    
    dist = DTW(end, end);
end
