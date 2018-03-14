function [result, distancesMeans] = ngsa(problem, config)
% NGSA  Execute the NSGA-II algorithm. Minimization of fitness is assumed.
    N = config.N;
    g = 1;
    optimalAvailable = isfield(problem, 'optimal');
	distancesMeans = zeros(config.maxGen, 1);

    % Initial population.
    pop = initSolutionPopulation(N, problem.varCount, problem.boundaries);
    
    if (optimalAvailable)
        % Optimal solutions (for distance computation per generation)
        optimalLinspace = zeros(problem.varCount, 1000);
        optimalValues = zeros(1000, problem.objCount);

        for v = 1:problem.varCount
            optimalLinspace(v, :) = linspace(problem.optimal(v, 1), problem.optimal(v, 2), 1000);
        end

        for o = 1:problem.objCount
            optimalValues(:, o) = problem.objectives{o}(optimalLinspace');
        end
    end
    
    while (g <= config.maxGen)
        if (g == 1)
            % First offspring.
            [~, ranks] = evalPop(pop, problem);
            ranksSelected = tournamentSelection(ranks, config.selectionArgs);
            offspring = pop(ranksSelected, :);
        else
            R = [pop; offspring];
            [objectivesValuesR, ranksR] = evalPop(R, problem);
            
            nextPop = zeros(N, 1);
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
                % Recompute distances.
                distances = crowdingDistanceAssignment(objectivesValuesR(frontIndices, :));

                % Calculate how many individual are missing.
                remainingCount = N - newPopCount;

                % Find the best ones available.
                [~, sortedIndices] = mink(-distances, remainingCount);
                absoluteIndices = frontIndices(sortedIndices);

                % Add them.
                remainingInterval = (newPopCount + 1):(newPopCount + length(absoluteIndices));
                nextPop(remainingInterval) = absoluteIndices;
                newPopCount = newPopCount + length(absoluteIndices);
            end
            
            pop = offspring;
            offspring = R(nextPop, :);
            
            selected = tournamentSelection(keepIndices, config.selectionArgs);
            offspring = offspring(selected, :);
        end
        
        % Crossover and mutation.
        offspring = simulatedBinaryCrossover(offspring, config.pc, config.crossArgs);
        offspring = polynomialMutation(offspring, config.pm, config.mutationArgs);
        
        if (optimalAvailable)
            % Distance computation.
            distances = zeros(N, 1);
            obtainedPareto = zeros(N, problem.objCount);
            closest = zeros(N, problem.objCount);

            for o = 1:problem.objCount
                obtainedPareto(:, o) = problem.objectives{o}(pop);
            end

            % Find closest optimal values...
            for n = 1:N
                [closest(n, :), ~] = min(abs(optimalValues - obtainedPareto(n, :)));
            end

            % ...and compute distances.
            for n = 1:N
                distances(n) = min(sum((obtainedPareto(n, :) - closest).^2, 2));
            end

            distancesMeans(g) = mean(sqrt(distances));
        end

        g = g + 1;
    end
    
    [~, ranks] = evalPop(pop, problem);
    result = pop(ranks == 1, :);
end
