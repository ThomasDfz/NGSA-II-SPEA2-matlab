function c = simulatedBinaryCrossover(matingPool, pc, args)
% SIMULATEDBINARYCROSSOVER  Apply the simulated binary crossover 
% operation to the mating pool.
%   The argument needed is n.

    c = zeros(length(matingPool), 1);
    n = args(1);
    constraints(1) = args(2);
    constraints(2) = args(3);
    
    for i = 1:length(matingPool)/2
        % No crossover here.
        if (rand > pc)
            c(2*i - 1) = matingPool(2*i - 1);
            c(2*i) = matingPool(2*i);
            continue;
        end
        
        u = rand;
        
        if u <= 0.5
            beta = (2 * u) ^ (1 / (n+1));
        elseif u > 0.5
            beta = (2 * (1 - u)) ^ (- (1/n) - 1);
        end

        parent1 = matingPool(2*i - 1);
        parent2 = matingPool(2*i);
        
        % Children.
        c(2*i - 1) = .5*(parent1 + parent2) + .5*beta*(parent1 - parent2);
        c(2*i) = .5*(parent1 + parent2) + .5*beta*(parent2 - parent1);
    end
    
    % Values can be evolve to be outside of the boundaries.
    c = strictNarrow(c, constraints);
end

