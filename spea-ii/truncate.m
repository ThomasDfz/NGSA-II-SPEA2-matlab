function archive = truncate(array, problem, Nbar)

    archive = array;

    if(problem.varCount == 1)
        archive = archive.';
    else
        archive = reshape(archive, [problem.varCount, size(archive, 2) / problem.varCount]);
        archive = transpose(archive);
    end

    distMatrix = zeros(size(archive, 1), size(archive, 1));
    for i = 1:size(archive, 1)
        for j = (i + 1):size(archive, 1)
            dist = 0;
            for k = 1:problem.objCount
                a = archive(i, :);
                b = archive(j, :);
                dist = dist + (problem.objectives{k}(a) - problem.objectives{k}(b))*(problem.objectives{k}(a) - problem.objectives{k}(b));
            end 
            distMatrix(i, j) = sqrt(dist);
        end
    end

    while(size(archive, 1) > Nbar)
        minDist = intmax('int64');
        minIndex = 0;
        for i = 1:size(distMatrix, 1)
            for j = (i + 1):size(distMatrix, 1)
                if distMatrix(i, j) < minDist
                    minDist = distMatrix(i, j);
                    minIndex = i;
                end
            end
        end    
        distMatrix = distMatrix([1:(minIndex - 1), (minIndex + 1):end], :);
        distMatrix = distMatrix(:, [1:(minIndex - 1), (minIndex + 1):end]);
        
        newArray = zeros(size(archive, 1) - 1, problem.varCount);
        for i = 1:(minIndex - 1)
            newArray(i) = archive(i);
        end
        for i = (minIndex + 1):size(archive, 1)
            newArray(i - 1) = archive(i);
        end
        archive = newArray;
    end

end