% Add subpaths to Matlab global path. Allows global usage of GA functions.
% Only need to be executed once.
addpath(genpath('.'));

% Choose the problem and the genetic config.
problem = zdt6();
config = geneticConfig(100, 250, 0.9, 1 / problem.varCount, ...
    [2], [20 problem.boundaries], 20);

% Execute NGSA-II.
[resultNgsa, distancesNgsa, deltaNgsa] = ngsa(problem, config);

% Draw graphes.
drawGraphes(problem, resultNgsa, distancesNgsa, deltaNgsa);
disp(resultNgsa);

% Benchmark
%r = benchmark(30, config);
%disp(r);
