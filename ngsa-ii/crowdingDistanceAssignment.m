function distances = crowdingDistanceAssignment(objectivesValues)
% CROWDINGDISTANCEASSIGNMENT  Crowding distance assignment.
    [N, M] = size(objectivesValues);
    distances = zeros(N, 1);
    
    for o = 1:M
        objValues = objectivesValues(:, o);
        
        [~, indices] = sort(objValues);
        
        objMinIndex = indices(1);
        objMaxIndex = indices(end);
        
        distances(objMinIndex) = Inf;
        distances(objMaxIndex) = Inf;
        
        objDelta = objValues(objMaxIndex) - objValues(objMinIndex);
        
        for i = 2:(N-1)
            distances(i) = distances(i) + ...
                (objValues(i + 1) - objValues(i - 1)) / objDelta;
        end
    end
end
