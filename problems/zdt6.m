function p = zdt6()
% ZDT6 ZDT6 problem
    p.varCount = 10;
    p.objCount = 3;
    p.objectives = {@zdt6_f1 @zdt6_f2 @zdt6_g};
    p.boundaries = [0 1];
end

function o = zdt6_f1(args)
    o = 1 - exp(-4 .* args(:, 1)) .* (sin(6 .* pi .* args(:, 1)).^6);
end

function o = zdt6_f2(args)
    o = zdt6_g(args) .* (1 - (zdt6_f1(args) ./ zdt6_g(args)).^2);
end


function o = zdt6_g(args)
    sum = 0;
    
    for i = 2:10
        sum = sum + args(:, i);
    end
    
    o = 1 + 9 .* ((sum ./ 9).^(0.25));
end
