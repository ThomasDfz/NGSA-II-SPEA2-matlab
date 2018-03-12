function p = zdt3()
% ZDT3 ZDT3 problem
    p.varCount = 30;
    p.objCount = 3;
    p.objectives = {@zdt3_f1 @zdt3_f2 @zdt3_g};
    p.boundaries = [0 1];
end

function o = zdt3_f1(args)
    o = args(:, 1);
end

function o = zdt3_f2(args)
    o = zdt3_g(args) .* (1 - sqrt(args(:, 1) ./ zdt3_g(args)) - ...
        (args(:, 1) ./ zdt3_g(args)) .* sin(10.*pi.*args(:, 1)));
end


function o = zdt3_g(args)
    sum = 0;
    
    for i = 2:30
        sum = sum + args(:, i);
    end
    
    o = 1 + 9 .* sum / 29;
end
