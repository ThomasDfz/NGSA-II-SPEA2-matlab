function p = kur()
% KUR KUR problem
    p.varCount = 3;
    p.objCount = 2;
    p.objectives = {@kur1 @kur2};
    p.boundaries = [-5 5];
    p.name = 'KUR';
end

function o = kur1(args)
    o = 0;
    
    for i = 1:2
        o = o + (-10 .* exp(-0.2 .* sqrt(args(:, i).^2 + args(:, i+1).^2)));
    end
end

function o = kur2(args)
    o = 0;
    
    for i = 1:3
        o = o + (abs(args(:, i)).^(0.8) + 5.*sin(args(:, i).^3));
    end
end

