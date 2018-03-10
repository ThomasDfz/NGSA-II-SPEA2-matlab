function d = dominate(i, j, objectives)
% DOMINATE  Check if the point i dominates the point j for the given
% objectives functions (minimization assumed).
    d = 0;

    for obj = objectives
        if (obj.fn(i) < obj.fn(j))
            d = 0;
            break;
        end

        if (obj.fn(i) > obj.fn(j))
            d = 1;
        end
    end
end

