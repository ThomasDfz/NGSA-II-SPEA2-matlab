function [objectivesValues, ranks] = evalPop(pop, problem)
% EVALPOP  Evaluate the population for each objective and assign ranks.
    [N, ~] = size(pop);
    objectivesValues = zeros(N, problem.objCount);

    for o = 1:problem.objCount
        objectivesValues(:, o) = problem.objectives{o}(pop);
    end
    
    ranks = fastNonDominatedSort(objectivesValues);
end
