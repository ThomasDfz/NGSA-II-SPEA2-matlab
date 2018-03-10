function selected = tournamentSelection(fitnesses, args)
% TOURNAMENTSELECTION  Select individuals based on the tournament
% algorithm. The argument needed is k, the number of individuals fighting
% between each other per round.

    k = args(1);
    N = length(fitnesses);
    selected = zeros(N, 1);
    
    if (k < 0 || k > N)
        k = randi(N);
    end
    
    for i = 1:N
        randIndividuals = randi(N, k, 1); % kx1 vector with rand from [1,N]
        randFits = fitnesses(randIndividuals);
        [~, idx] = min(randFits);
        selected(i) = randIndividuals(idx);
    end
end
