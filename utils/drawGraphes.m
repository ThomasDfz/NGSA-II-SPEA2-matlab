function drawGraphes(problem, resultNgsa, distancesNgsa, deltaNgsa, resultSpea, distancesSpea, deltaSpea)
    [Nngsa, ~] = size(resultNgsa);
    [Nspea, ~] = size(resultSpea);
    optimalAvailable = isfield(problem, 'optimal');
    objectivesValuesNgsa = zeros(Nngsa, problem.objCount);
    objectivesValuesSpea = zeros(Nspea, problem.objCount);
	[Gmax, ~] = size(deltaNgsa);
    
    if (optimalAvailable)
        optimalValues = zeros(1000, problem.objCount);
        optimalLinspace = zeros(problem.varCount, 1000);

        for v = 1:problem.varCount
            optimalLinspace(v, :) = linspace(problem.optimal(v, 1), problem.optimal(v, 2), 1000);
        end
    end
    
    for o = 1:problem.objCount
        objectivesValuesNgsa(:, o) = problem.objectives{o}(resultNgsa);
        objectivesValuesSpea(:, o) = problem.objectives{o}(resultSpea);
        
        if (isfield(problem, 'optimal'))
            optimalValues(:, o) = problem.objectives{o}(optimalLinspace');
        end
    end
    
    figure(1);
    clf;
    
    % Pareto front (objective domain)
    if (optimalAvailable)
        subplot(2, 2, [1, 2]);
    end

    % Result front
    plot(objectivesValuesNgsa(:, 1), objectivesValuesNgsa(:, 2), 'or');
    
    hold on;
    plot(objectivesValuesSpea(:, 1), objectivesValuesSpea(:, 2), 'ob');
    hold off;
    
    title(strcat("(Objective domain) Pareto fronts for ", problem.name));
    xlabel("F_1");
    ylabel("F_2");

    if (optimalAvailable)
        hold on;
        % Optimal front
        plot(optimalValues(:, 1), optimalValues(:, 2), '-k');
        hold off;
        legend('NGSA-II Pareto front', 'SPEA2 Pareto front','Optimal Pareto front');
        
        % Distance metric
        subplot(2, 2, 3);
        
        plot(linspace(1, Gmax, Gmax), log10(distancesNgsa), '-+r');
        
        hold on;
        plot(linspace(1, Gmax, Gmax), log10(distancesSpea), '-+b');
        hold off;

        title(strcat("Distance metric for ", problem.name));
        xlabel("Generation");
        ylabel("Distance (Log_{10})");
        legend("NGSA-II distances", "SPEA2 distances");
        
        % Diversity of solutions
        subplot(2, 2, 4);
        
        plot(linspace(1, Gmax, Gmax), log10(deltaNgsa), '-+r');
        
        hold on;
        plot(linspace(1, Gmax, Gmax), log10(deltaSpea), '-+b');
        hold off;

        title(strcat("Diversity metric for ", problem.name));
        xlabel("Generation");
        ylabel("Delta (Log_{10})");
        legend("NGSA-II diversity", "SPEA2 diversity", "Location", "Southeast");
    else
        legend('NGSA-II Pareto front', 'SPEA2 Pareto front');
    end
end