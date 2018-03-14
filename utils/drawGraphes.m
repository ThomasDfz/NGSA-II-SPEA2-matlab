function drawGraphes(problem, resultNgsa, distancesNgsa, deltaNgsa)
    [N, ~] = size(resultNgsa);
    optimalAvailable = isfield(problem, 'optimal');
    objectivesValues = zeros(N, problem.objCount);
	[Gmax, ~] = size(deltaNgsa);
    
    if (optimalAvailable)
        optimalValues = zeros(N, problem.objCount);
        optimalLinspace = zeros(problem.varCount, N);

        for v = 1:problem.varCount
            optimalLinspace(v, :) = linspace(problem.optimal(v, 1), problem.optimal(v, 2), N);
        end
    end
    
    for o = 1:problem.objCount
        objectivesValues(:, o) = problem.objectives{o}(resultNgsa);
        
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
    plot(objectivesValues(:, 1), objectivesValues(:, 2), 'o');

    title(strcat("(Objective domain) Pareto fronts for ", problem.name));
    xlabel("F_1");
    ylabel("F_2");

    if (optimalAvailable)
        hold on;
        % Optimal front
        plot(optimalValues(:, 1), optimalValues(:, 2), '-r');
        hold off;
        legend('NGSA-II Pareto front', 'Optimal Pareto front');
        
        % Distance metric
        subplot(2, 2, 3);
        
        plot(linspace(1, Gmax, Gmax), log10(distancesNgsa), '-+');

        title(strcat("Distance metric for ", problem.name));
        xlabel("Generation");
        ylabel("Distance (Log_{10})");
        legend("NGSA-II distances");
        
        % Diversity of solutions
        subplot(2, 2, 4);
    else
        legend('NGSA-II Pareto front');
        
        % Diversity of solutions
        subplot(2, 2, [3, 4]);
    end
    
    plot(linspace(1, Gmax, Gmax), log10(deltaNgsa), '-+');
    
    title(strcat("Diversity metric for ", problem.name));
    xlabel("Generation");
    ylabel("Delta (Log_{10})");
    legend("NGSA-II diversity", "Location", "Southeast");
end