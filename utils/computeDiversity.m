function delta = computeDiversity(popNonDominated, objValues, optValues)
% COMPUTEDIVERSITY  Compute diversity of the solutions.

    [N, ~] = size(popNonDominated);
    [~, optIndices] = sort(optValues(:, 1));
    sortedOptValues = optValues(optIndices, :);
    
    if (N <= 1)
        delta = 0;
    else
        distances = zeros(N - 1, 1);
        [~, indexes] = sort(objValues(:, 1));
        objSortedValues = objValues(indexes, :);

        for n = 1:(N - 1)
            distances(n) = euclidianDistance(objValues(indexes(n), :), objValues(indexes(n+1), :));
        end

        avg = mean(distances);
        df = euclidianDistance(sortedOptValues(1, :), objSortedValues(1, :));
        dl = euclidianDistance(sortedOptValues(end, :), objSortedValues(end, :));

        delta = (df + dl + sum(abs(distances - avg))) / (df + dl + (N - 1)*avg);
    end
end

function distance = euclidianDistance(p1, p2)
    distance = sqrt((p2(1) - p1(1)).^2 + (p2(2) - p1(2)).^2);
end
