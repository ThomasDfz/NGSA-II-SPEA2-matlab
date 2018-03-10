function F = fastNonDominatedSort(objectivesValues)
% FASTNONDOMINATEDSORT  A fast non dominated sorting algorithm.
    [N, M] = size(objectivesValues);
    F = zeros(N, 1);
    indices = 1:N;
    indicesCount = N;
    frontIndex = 1;
    
    while (indicesCount > 0)
        pts = objectivesValues(indices, :);
        isNonDominated = zeros(indicesCount, 1);
        
        for i = 1:indicesCount
            % Sum by row.
            isDominated = sum(pts < pts(i, :), 2) == M;
            isNonDominated(i) = sum(isDominated) == 0;
        end
        
        nonDominatedIndicesRelative = isNonDominated ~= 0;
        nonDominatedIndicesAbsolute = indices(nonDominatedIndicesRelative);
        
        F(nonDominatedIndicesAbsolute) = frontIndex;
        
        indices(nonDominatedIndicesRelative) = [];
        indicesCount = indicesCount - length(nonDominatedIndicesAbsolute);
        
        frontIndex = frontIndex + 1;
    end
end
