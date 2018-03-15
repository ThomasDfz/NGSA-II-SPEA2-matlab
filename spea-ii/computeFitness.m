function [fitnessPop, fitnessArchive] = computeFitness(pop, archive, problem, firstRound)

    varCount = problem.varCount;

    if(firstRound == 1)
        S = zeros(size(pop, 1), 1);
        R = zeros(size(pop, 1), 1);
        individuals = pop;
    else
        S = zeros(size(pop, 1) + size(archive, 1), 1);
        R = zeros(size(pop, 1) + size(archive, 1), 1);
        individuals = zeros(size(pop, 1) + size(archive, 1), varCount); 
        for i = 1:size(pop, 1)
            individuals(i) = pop(i);
        end
        for i = 1:size(archive, 1)
            individuals(size(pop, 1) + i) = archive(i);
        end
    end
    
    dominationMatrix = zeros(size(individuals, 1), size(individuals, 1));

    for i = 1:size(individuals, 1)
        for j = 1:(i-1)
            if(dominate(individuals(i, :), individuals(j, :), problem) > 0)
                dominationMatrix(i, j) = 1;
                dominationMatrix(j, i) = -1;
                S(i, 1) = S(i, 1) + 1;
            end
        end
        for j = (i+1):size(individuals, 1)
            if(dominate(individuals(i, :), individuals(j, :), problem) > 0)
                dominationMatrix(i, j) = 1;
                dominationMatrix(j, i) = -1;
                S(i, 1) = S(i, 1) + 1;
            end      
        end
    end
  
    for i = 1:size(S, 1)
        for j = 1:(i-1)
            %{
            if(dominate(individuals(j, :), individuals(i, :), problem) > 0)
                R(i, 1) = R(i, 1) + S(j, 1);
            end
            %}
            if(dominationMatrix(j, i) == 1)
                R(i, 1) = R(i, 1) + S(j, 1);
            end
        end
        for j = (i+1):size(individuals, 1)
            %{
            if(dominate(individuals(j, :), individuals(i, :), problem) > 0)
                R(i, 1) = R(i, 1) + S(j, 1);
            end      
            %}
            if(dominationMatrix(j, i) == 1)
                R(i, 1) = R(i, 1) + S(j, 1);
            end
        end
    end  

    if(firstRound == 1)
        fitnessPop = R;
        fitnessArchive = 0;
    else
        fitnessPop = zeros(size(pop, 1), 1);
        fitnessArchive = zeros(size(archive, 1), 1);
        for i = 1:size(pop, 1)
            fitnessPop(i, 1) = R(i, 1);
        end
        for i = 1:size(archive, 1)
            fitnessArchive(i, 1) = R(i + size(pop, 1), 1); 
        end
    end

end