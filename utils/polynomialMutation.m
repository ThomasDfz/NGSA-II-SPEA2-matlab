function pop = polynomialMutation(pop, mutateProb, args)
% POLYNOMIALMUTATION  Apply the polynomial mutation operation to the population.
%   The argument needed is n.

    n = args(1);
    
    for i = 1:length(pop)    
        if (rand < mutateProb) 
            u = rand;
            if u < 0.5
                ksi = (2*u) ^ (1/(n + 1)) - 1; 
            elseif u >= 0.5
                ksi = 1 - (2*(1 - u)) ^ (1/(n+1));
            end
            
            pop(i) = pop(i) + ksi; 
        end
    end
end