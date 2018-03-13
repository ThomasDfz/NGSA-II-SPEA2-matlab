% Add subpaths to Matlab global path. Allows global usage of GA functions.
% Only need to be executed once.
addpath(genpath('.'));

problem = sch();
config = geneticConfig(100, 250, 0.9, 1 / problem.varCount, ...
    [2], [20 problem.boundaries], 20);

result = ngsa(problem, config);
disp(result);
