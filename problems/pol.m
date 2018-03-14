function p = pol()
% POL POL problem
    p.varCount = 2;
    p.objCount = 2;
    p.objectives = {@pol1 @pol2};
    p.boundaries = [-pi pi];
    p.name = 'POL';
end

function o = pol1(args)
    A1 = 0.5*sin(1) - 2*cos(1) + sin(2) - 1.5*cos(2);
    A2 = 1.5*sin(1) - cos(1) + 2*sin(2) - 0.5*cos(2);
    B1 = 0.5.*sin(args(:, 1)) - 2.*cos(args(:, 1)) + sin(args(:, 2)) - 1.5.*cos(args(:, 2));
    B2 = 1.5.*sin(args(:, 1)) - cos(args(:, 1)) + 2.*sin(args(:, 2)) - 0.5.*cos(args(:, 2));

    o = 1 + (A1 - B1).^2 + (A2 - B2).^2;
end

function o = pol2(args)
    o = (args(:, 1) + 3).^2 + (args(:, 2) + 1).^2;
end

