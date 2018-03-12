function c = simulatedBinaryCrossover(matingPool, pc, args)
% SIMULATEDBINARYCROSSOVER  Apply the simulated binary crossover 
% operation to the mating pool.
%   The argument needed is n.

    [N, M] = size(matingPool);
    c = zeros(N, M);
    n = args(1);
    constraints(1) = args(2);
    constraints(2) = args(3);
    
    for m = 1:M
        for i = 1:length(matingPool)/2
            % No crossover here.
            if (rand > pc)
                c(2*i - 1, m) = matingPool(2*i - 1, m);
                c(2*i, m) = matingPool(2*i, m);
                continue;
            end

            u = rand;

            if u <= 0.5
                beta = (2 * u) ^ (1 / (n+1));
            elseif u > 0.5
                beta = (2 * (1 - u)) ^ (- (1/n) - 1);
            end

            parent1 = matingPool(2*i - 1, m);
            parent2 = matingPool(2*i, m);

            % Children.
            c(2*i - 1, m) = .5*(parent1 + parent2) + .5*beta*(parent1 - parent2);
            c(2*i, m) = .5*(parent1 + parent2) + .5*beta*(parent2 - parent1);
        end
    end
    
    % Values can be evolve to be outside of the boundaries.
    c = strictNarrow(c, constraints);
end

