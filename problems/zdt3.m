function p = zdt3()
% ZDT3 ZDT3 problem
    p.varCount = 30;
    p.objCount = 2;
    p.objectives = {@zdt3_f1 @zdt3_f2};
    p.boundaries = [0 1];
    p.optimal = [0 1; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0;];
    p.name = 'ZDT3';
end

function o = zdt3_f1(args)
    o = args(:, 1);
end

function o = zdt3_f2(args)
    o = zdt3_g(args) .* (1 - sqrt(args(:, 1) ./ zdt3_g(args)) - ...
        (args(:, 1) ./ zdt3_g(args)) .* sin(10 .* pi .* args(:, 1)));
end

function o = zdt3_g(args)    
    o = 1 + 9 .* sum(args(:, 2:end), 2) ./ 29;
end
