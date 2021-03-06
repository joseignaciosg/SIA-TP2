function [patterns] = shufflePatterns(series, windowsize,shuffle)
    n = length(series)-windowsize;
    patterns = zeros(n,windowsize+1);
    for i=1:n
         patterns(i,:) = series(i:i+windowsize);
    end
    if (shuffle)
        patterns = patterns(randperm(size(patterns,1)),:);
    end
end