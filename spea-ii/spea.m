function [A, distancesMeans, delta] = spea(problem, config)

    N = config.N;
    Nbar = N;
    T = config.maxGen;
    xMin = problem.boundaries(1);
    xMax = problem.boundaries(2);
    varCount = problem.varCount;

    optimalAvailable = isfield(problem, 'optimal');
    distancesMeans = zeros(config.maxGen, 1);
    delta = zeros(config.maxGen, 1);

    pop = xMin + rand(N, varCount) * (xMax - xMin);
    archive = zeros(Nbar, varCount);
    t = 0;
    firstRound = 1;
    over = 0;

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

    while(over == 0)
        if(firstRound == 1)
            [fitnessPop, fitnessArchive] = computeFitness(pop, archive, problem, 1);
        else
            [fitnessPop, fitnessArchive] = computeFitness(pop, archive, problem, 0);
        end

        newArchive = {};

        for i = 1:size(fitnessPop, 1)
            if fitnessPop(i, 1) == 0
                newArchive = [newArchive, pop(i, :)];
            end
        end 
        
          
        if firstRound == 0
            for i = 1:size(fitnessArchive, 1)
                if fitnessArchive(i, 1) == 0
                    newArchive = [newArchive, archive(i, :)];
                end
            end
        end

        if size(newArchive, 2) > Nbar
            newArchive = cell2mat(newArchive);
            newArchive = truncate(newArchive, problem, Nbar);
        else
            i = 1;

            while size(newArchive, 2) < Nbar && i <= N
                if fitnessPop(i, 1) ~= 0
                    newArchive = [newArchive, pop(i, :)];
                    i = i + 1;
                else
                    i = i + 1;
                end
            end

            i = 1;
            if firstRound ~= 1
                while size(newArchive, 2) < Nbar && i <= Nbar
                    if fitnessArchive(i, 1) ~= 0
                        newArchive = [newArchive, archive(i, :)];
                        i = i + 1;
                    else
                        i = i + 1;
                    end
                end
            end  

            newArchive = cell2mat(newArchive);
            
            if(varCount == 1)
                newArchive = newArchive.';
            else
                newArchive = reshape(newArchive, [varCount, Nbar]);
                newArchive = transpose(newArchive);
            end
        end
        
        firstRound = 0;

        fitnesses = zeros(size(newArchive, 1), 1);
        for i = 1:size(fitnesses, 1)
            for j = 1:problem.objCount
                fitnesses(i, 1) = fitnesses(i, 1) + problem.objectives{j}(newArchive(i, :)); 
            end
        end
        
        tournamentResult = tournamentSelection(fitnesses, [2]);
        
        matingPool = zeros(size(tournamentResult, 1), varCount);
        for i = 1:size(tournamentResult, 1)
            matingPool(i) = newArchive(tournamentResult(i, 1));
        end
    
        offspring = simulatedBinaryCrossover(matingPool, config.pc, config.crossArgs);   
        offspring = polynomialMutation(offspring, config.pm, config.mutationArgs);
        
        
       
        pop = offspring;
        for i = 1:size(newArchive, 1)
            archive(i) = newArchive(i);
            for j = 1:problem.varCount
                if archive(i, j) < xMin
                    archive(i, j) = xMin;
                elseif archive(i, j) > xMax
                    archive(i, j) = xMax;
                end
            end
        end  
        for i = 1:size(pop, 1)
            for j = 1:problem.varCount
                if pop(i, j) < xMin
                    pop(i, j) = xMin;
                elseif pop(i, j) > xMax
                    pop(i, j) = xMax;
                end
            end
        end     
 
        % Distance computation.
        if (optimalAvailable)
            distances = zeros(N, 1);
            obtainedPareto = zeros(N, problem.objCount);

            for o = 1:problem.objCount
                obtainedPareto(:, o) = problem.objectives{o}(pop);
            end

            % Find closest optimal values and compute distances.
            for n = 1:N
                distances(n) = min(sum((obtainedPareto(n, :) - optimalValues).^2, 2));
            end

            distancesMeans(t + 1) = mean(sqrt(distances));

            [objValues, ranks] = evalPop(pop, problem);
            delta(t+1) = computeDiversity(pop(ranks == 1, :), objValues(ranks == 1, :), optimalValues);
        end
        
        t = t + 1;

        if t >= T
            over = 1;
        end    

    end

    A = archive;  

end