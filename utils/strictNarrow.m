function pop = strictNarrow(pop, constraints)
% STRICTNARROW  Apply the strict narrow operation to the population in case
% the values of the population are outside the boundaries.

    for i = 1:length(pop)
        if (pop(i) < constraints(1))
            pop(i) = constraints(1);
        elseif (pop(i) > constraints(2))
            pop(i) = constraints(2);
        end
    end
end
