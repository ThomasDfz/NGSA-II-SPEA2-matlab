function p = zdt2()
% ZDT2 ZDT2 problem
    p.varCount = 30;
    p.objCount = 2;
    p.objectives = {@zdt2_f1 @zdt2_f2};
    p.boundaries = [0 1];
    p.optimal = [0 1; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0;];
    p.name = 'ZDT2';
end

function o = zdt2_f1(args)
    o = args(:, 1);
end

function o = zdt2_f2(args)
    o = zdt2_g(args) .* (1 - (args(:, 1) ./ zdt2_g(args)).^2);
end

function o = zdt2_g(args)
    o = 1 + 9 .* sum(args(:, 2:end), 2) ./ 29;
end
