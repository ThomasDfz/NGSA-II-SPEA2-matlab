function pop = strictNarrow(pop, constraints)
% STRICTNARROW  Apply the strict narrow operation to the population in case
% the values of the population are outside the boundaries.

    pop = max(min(pop, constraints(2)), constraints(1));
end
