function values = initSolutionIndividual(vc, boundaries)
% INITINDIVIDUAL  Initialize an individual.
    lb = boundaries(1);
    ub = boundaries(2);
    
    values = lb + rand(1, vc) .* (ub - lb);
end
