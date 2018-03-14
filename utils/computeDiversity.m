function delta = computeDiversity(popNonDominated, objValues, optValues)
% COMPUTEDIVERSITY  Compute diversity of the solutions.

    [N, ~] = size(popNonDominated);
    [~, optIndices] = sort(optValues(:, 1));
    
    if (N <= 1)
        delta = 0;
    else
        distances = zeros(N - 1, 1);
        [~, indexes] = sort(objValues(:, 1));

        for n = 1:(N - 1)
            distances(n) = euclidianDistance(objValues(indexes(n), :), objValues(indexes(n+1), :));
        end

        avg = mean(distances);
        sdist = sum(distances);
        df = optValues(optIndices(1)) - distances(1);
        dl = optValues(optIndices(end)) - distances(end);

        delta = (df + dl + abs(sdist - (N - 1)*avg)) / (df + dl + (N - 1)*avg);
    end
end

function distance = euclidianDistance(p1, p2)
    distance = sqrt((p2(1) - p1(1)).^2 + (p2(2) - p1(1)).^2);
end
