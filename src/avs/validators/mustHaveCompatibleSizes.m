function mustHaveCompatibleSizes(A, B)
% MUSTHAVECOMPATIBLESIZES Validate that values have compatible sizes
%
%   MUSTHAVECOMPATIBLESIZES(A, B) throws an error is sizes of A nd B are
%   incompatible. Two arrays have compatible sizes if, for every
%   dimension, the dimension sizes of the arrays are either the same or
%   one of them is 1.

as = size(A);
bs = size(B);

ml = max(length(as), length(bs));
as(end+1:ml) = 1;
bs(end+1:ml) = 1;

if ~all((as == bs) | (as == 1 | bs == 1))
    throwAsCaller(MException( ...
        "AVS:validators:mustHaveCompatibleSizes", ...
        "Arrays must have compatible sizes."));
end

end
