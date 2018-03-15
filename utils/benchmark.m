function results = benchmark(iterationCount, config)
%BENCHMARK  Benchmark the NGSA-II and the SPEA2 algorithms.

    s = sch();
    f = fon();
    z1 = zdt1();
    z2 = zdt2();
    z3 = zdt3();
    z6 = zdt6();
    problems = [s];
    results = cell(2, length(problems), iterationCount);
    
    for p = 1:length(problems)
        disp(strcat("Problem ", problems(p).name));
        for i = 1:iterationCount
            disp(strcat("Iteration ", int2str(i)));
            
            [~, dist, delta] = ngsa(problems(p), config);
            results{1, p, i}.distances = dist;
            results{1, p, i}.deltas = delta;
            
            [~, dist, delta] = spea(problems(p), config);
            results{2, p, i}.distances = dist;
            results{2, p, i}.deltas = delta;
        end
    end
    
    benchmarkGraphes(problems, results, config);
end

function benchmarkGraphes(problems, results, config)
    problem = problems(1);    
    optimalAvailable = isfield(problem, 'optimal');
    Gmax = config.maxGen;
    
    figure(1);
    clf;
    
    if (optimalAvailable)        
        % Distance metric
        subplot(1, 2, 1);
        
        distanceNgsa = zeros(Gmax, length(results{1, 1, 1}.distances));
        distanceSpea = zeros(Gmax, length(results{2, 1, 1}.distances));
        for i = 1:Gmax
            distanceNgsa(:, i) = results{1, 1, i}.distances;
            distanceSpea(:, i) = results{2, 1, i}.distances;
        end
        
        plot(linspace(1, Gmax, Gmax), log10(mean(distanceNgsa)), '-+r');
        
        hold on;
        plot(linspace(1, Gmax, Gmax), log10(mean(distanceSpea)), '-+b');
        hold off;

        title(strcat("Distance metric for ", problem.name));
        xlabel("Generation");
        ylabel("Distance (Log_{10})");
        legend("NGSA-II distances", "SPEA2 distances");
        
        % Diversity of solutions
        subplot(1, 2, 2);
        
        deltaNgsa = zeros(Gmax, length(results{1, 1, 1}.deltas));
        deltaSpea = zeros(Gmax, length(results{2, 1, 1}.deltas));
        for i = 1:Gmax
            deltaNgsa(:, i) = results{1, 1, i}.deltas;
            deltaSpea(:, i) = results{2, 1, i}.deltas;
        end
        
        plot(linspace(1, Gmax, Gmax), log10(mean(deltaNgsa)), '-+r');
        
        hold on;
        plot(linspace(1, Gmax, Gmax), log10(mean(deltaSpea)), '-+b');
        hold off;

        title(strcat("Diversity metric for ", problem.name));
        xlabel("Generation");
        ylabel("Delta (Log_{10})");
        legend("NGSA-II diversity", "SPEA2 diversity", "Location", "Southeast");
    end
end
