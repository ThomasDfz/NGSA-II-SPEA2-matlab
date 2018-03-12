function p = zdt2()
% ZDT2 ZDT2 problem
    p.varCount = 30;
    p.objCount = 3;
    p.objectives = {@zdt2_f1 @zdt2_f2 @zdt2_g};
    p.boundaries = [0 1];
end

function o = zdt2_f1(args)
    o = args(:, 1);
end

function o = zdt2_f2(args)
    o = zdt2_g(args) .* (1 - (args(:, 1) ./ zdt2_g(args)).^2);
end


function o = zdt2_g(args)
    sum = 0;
    
    for i = 2:30
        sum = sum + args(:, i);
    end
    
    o = 1 + 9 .* sum / 29;
end
