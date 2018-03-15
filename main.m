% Add subpaths to Matlab global path. Allows global usage of GA functions.
% Only need to be executed once.
addpath(genpath('.'));

% Choose the problem and the genetic config.
problem = sch();

% Every test in the report has been done with thoses values
% it may take a few minutes though.
%config = geneticConfig(100, 250, 0.9, 1 / problem.varCount, ...
%    [2], [20 problem.boundaries], 20);

    
% Less time-consuming. Run this for a sneak peek.
config = geneticConfig(50, 50, 0.9, 1 / problem.varCount, ...
    [2], [20 problem.boundaries], 20);
    
% Execute SPEA2 & NGSA-II.
[resultNgsa, distancesNgsa, deltaNgsa] = ngsa(problem, config);
[resultSpea, distancesSpea, deltaSpea] = spea(problem, config);

% Draw graphes.
drawGraphes(problem, resultNgsa, distancesNgsa, deltaNgsa, resultSpea, distancesSpea, deltaSpea);

% Benchmark
%r = benchmark(30, config);
