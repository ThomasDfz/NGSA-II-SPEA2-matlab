function delta = computeDiversity(popNonDominated, objValues)
% COMPUTEDIVERSITY  Compute diversity of the solutions.

    [N, ~] = size(popNonDominated);
    
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
        df = distances(1);
        dt = distances(end);

        delta = (df + dt + abs(sdist - avg)) / (df + dt + (N - 1)*avg);
    end
end

function distance = euclidianDistance(p1, p2)
    distance = sqrt((p2(1) - p1(1)).^2 + (p2(2) - p1(1)).^2);
end
