function p = zdt6()
% ZDT6 ZDT6 problem
    p.varCount = 10;
    p.objCount = 2;
    p.objectives = {@zdt6_f1 @zdt6_f2};
    p.boundaries = [0 1];
    p.optimal = [0 1; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; ...
        0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0;];
    p.name = 'ZDT6';
end

function o = zdt6_f1(args)
    o = 1 - exp(-4 .* args(:, 1)) .* (sin(6 .* pi .* args(:, 1)).^6);
end

function o = zdt6_f2(args)
    o = zdt6_g(args) .* (1 - (zdt6_f1(args) ./ zdt6_g(args)).^2);
end

function o = zdt6_g(args)
    o = 1 + 9 .* ((sum(args(:, 2:end), 2) ./ 9).^(0.25));
end
