function Xcols = describeX(Xcols,shorthand,longhand,indices,start)

% row: row index in the description array
% shorthand: short label for the group of variables
% longhand: full description of the group of variables
% indices: index list length and pattern, starting from 1
% start: start index (if NaN, use the last index of the previous row plus 1)

if isnan(start)
    Xcols(end+1,:) = {shorthand,longhand,indices+Xcols{end,3}(end)};
else
    indexset = [];
    for n = 1:numel(start)
        indexset = [indexset,indices+start(n)-1];
    end
    Xcols(end+1,:) = {shorthand,longhand,indexset};
end

