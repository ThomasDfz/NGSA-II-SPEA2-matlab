function p = zdt1()
% ZDT1 ZDT1 problem
    p.varCount = 30;
    p.objCount = 3;
    p.objectives = {@zdt1_f1 @zdt1_f2 @zdt1_g};
    p.boundaries = [0 1];
end

function o = zdt1_f1(args)
    o = args(:, 1);
end

function o = zdt1_f2(args)
    o = zdt1_g(args) .* (1 - sqrt(args(:, 1) ./ zdt1_g(args)));
end


function o = zdt1_g(args)
    sum = 0;
    
    for i = 2:30
        sum = sum + args(:, i);
    end
    
    o = 1 + 9 .* sum / 29;
end
