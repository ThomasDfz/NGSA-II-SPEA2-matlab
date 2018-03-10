function p = sch()
    p.varCount = 1;
    p.objCount = 2;
    p.objectives = {@sch1 @sch2};
    p.boundaries = [-1000 1000];
end

function o = sch1(args)
    x = args(:, 1);
    o = x.*x;
end

function o = sch2(args)
    x = args(:, 1);
    o = (x - 2).^2;
end

