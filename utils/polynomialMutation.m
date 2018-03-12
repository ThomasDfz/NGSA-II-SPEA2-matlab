function pop = polynomialMutation(pop, mutateProb, args)
% POLYNOMIALMUTATION  Apply the polynomial mutation operation to the population.
%   The argument needed is n.

    n = args(1);
    [N, M] = size(pop);
    
    for m = 1:M
        for i = 1:N    
            if (rand < mutateProb) 
                u = rand;
                if u < 0.5
                    ksi = (2*u) ^ (1/(n + 1)) - 1; 
                elseif u >= 0.5
                    ksi = 1 - (2*(1 - u)) ^ (1/(n+1));
                end

                pop(i, m) = pop(i, m) + ksi; 
            end
        end
    end
end