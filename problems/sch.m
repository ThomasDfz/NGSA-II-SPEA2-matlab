function p = sch()
% SCH  SCH problem
    p.varCount = 1;
    p.objCount = 2;
    p.objectives = {@sch1 @sch2};
    p.boundaries = [-1000 1000];
    p.optimal = [0 2];
    p.name = 'SCH';
end

function o = sch1(args)
    x = args(:, 1);
    o = x.*x;
end

function o = sch2(args)
    x = args(:, 1);
    o = (x - 2).^2;
end

