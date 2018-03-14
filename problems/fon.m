function p = fon()
% FON  FON problem
    p.varCount = 3;
    p.objCount = 2;
    p.objectives = {@fon1 @fon2};
    p.boundaries = [-4 4];
    p.optimal = [-1/sqrt(3) 1/sqrt(3); -1/sqrt(3) 1/sqrt(3); ...
        -1/sqrt(3) 1/sqrt(3)];
    p.name = 'FON';
end

function o = fon1(args)
    sum = 0;
    
    for i = 1:3
        sum = sum + (args(:, i) - 1./sqrt(3)).^2;
    end
    
    o = 1 - exp(-sum);
end

function o = fon2(args)
    sum = 0;
    
    for i = 1:3
        sum = sum + (args(:, i) + 1./sqrt(3)).^2;
    end
    
    o = 1 - exp(-sum);
end

