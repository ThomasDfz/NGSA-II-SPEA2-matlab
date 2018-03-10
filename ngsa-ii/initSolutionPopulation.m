function pop = initSolutionPopulation(N, vc, boundaries)
    % Initialize the first generation.
    pop = zeros(N, vc);
    
    for n = 1:N
        pop(n, :) = initSolutionIndividual(vc, boundaries);
    end
end
