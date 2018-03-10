function config = geneticConfig(N, maxGen, crossProb, mutProb, ...
    selectionArgs, crossoverArgs, mutationArgs)
    % Configuration containing the population size, max number of 
    % generation, probabilities of crossover and mutation, 
    % and additional arguments.
    config.N = N;
    config.maxGen = maxGen;
    config.pc = crossProb;
    config.pm = mutProb;
    config.selectionArgs = selectionArgs;
    config.crossArgs = crossoverArgs;
    config.mutationArgs = mutationArgs;
end