function results = benchmark(iterationCount, config)
%BENCHMARK  Benchmark the NGSA-II and the SPEA2 algorithms.

    s = sch();
    f = fon();
    z1 = zdt1();
    z2 = zdt2();
    z3 = zdt3();
    z6 = zdt6();
    problems = [s f z1 z2 z3 z6];
    results = cell(2, length(problems), iterationCount);
    
    for p = 1:length(problems)
        disp(strcat("Problem ", problems(p).name));
        for i = 1:iterationCount
            disp(strcat("Iteration ", int2str(i)));
            [~, dist, delta] = ngsa(problems(p), config);
            results{1, p, i}.distances = dist;
            results{1, p, i}.deltas = delta;
        end
    end
end

