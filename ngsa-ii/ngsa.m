function result = ngsa(problem, config)
% NGSA  Execute the NSGA-II algorithm. Minimization of fitness is assumed.
    N = config.N;
    g = 1;
    
    % Initial population.
    pop = initSolutionPopulation(N, problem.varCount, problem.boundaries);
    
    while (g <= config.maxGen)
        if (g == 1)
            % First offspring.
            [~, ranks] = evalPop(pop, problem);
            ranksSelected = tournamentSelection(ranks, config.selectionArgs);
            offspring = pop(ranksSelected, :);
        else
            R = [pop; offspring];
            [objectivesValuesR, ranksR] = evalPop(R, problem);
            
            nextPop = zeros(N, problem.varCount);
            i = 1;
            newPopCount = 0;
            frontIndices = find(ranksR == i);
            frontCount = length(frontIndices);
            keepIndices = zeros(N, 1);
            
            while (newPopCount + frontCount <= N || newPopCount == 0)
                if (newPopCount + frontCount > N)
                    frontIndices = frontIndices((newPopCount + 1):N);
                    frontCount = N;
                end
                
                distances = crowdingDistanceAssignment(objectivesValuesR(frontIndices, :));
                
                newIndices = (newPopCount + 1):(newPopCount + frontCount);
                nextPop(newIndices) = frontIndices;
                
                % Sort sorts in ascending order hence the minus.
                [~, s] = sort(-distances);
                s = s / (frontCount + 1);

                keepIndices(newIndices) = i + s;
                
                i = i + 1;
                newPopCount = newPopCount + frontCount;
                
                frontIndices = find(ranksR == i);
                frontCount = length(frontIndices);
            end
                        
            if (newPopCount < N)
                remainingCount = N - newPopCount;
                [~, sortedIndices] = mink(-distances, remainingCount);
                absoluteIndices = frontIndices(sortedIndices);
                remainingInterval = (newPopCount:(newPopCount + length(absoluteIndices)));
                nextPop(remainingInterval) = absoluteIndices;
            end
            
            pop = offspring;
            offspring = R(nextPop, :);
            
            selected = tournamentSelection(keepIndices, config.selectionArgs);
            offspring = offspring(selected, :);
        end
        
        % Crossover and mutation.
        offspring = simulatedBinaryCrossover(offspring, config.pc, config.crossArgs);
        offspring = polynomialMutation(offspring, config.pm, config.mutationArgs);
                
        g = g + 1;
    end
    
    result = offspring;
end

function [objectivesValues, ranks] = evalPop(pop, problem)
    [N, ~] = size(pop);
    objectivesValues = zeros(N, problem.objCount);

    for o = 1:problem.objCount
        objectivesValues(:, o) = problem.objectives{o}(pop);
    end
    
    ranks = fastNonDominatedSort(objectivesValues);
end
