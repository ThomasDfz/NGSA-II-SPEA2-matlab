function p = zdt1()
% ZDT1 ZDT1 problem
    p.varCount = 30;
    p.objCount = 2;
    p.objectives = {@zdt1_f1 @zdt1_f2};
    p.boundaries = [0 1];
    p.optimal = [0 1; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0;];
    p.name = 'ZDT1';
end

function o = zdt1_f1(args)
    o = args(:, 1);
end

function o = zdt1_f2(args)
    o = zdt1_g(args) .* (1 - sqrt(args(:, 1) ./ zdt1_g(args)));
end

function o = zdt1_g(args)    
    o = 1 + 9 .* sum(args(:, 2:end), 2) ./ 29;
end
