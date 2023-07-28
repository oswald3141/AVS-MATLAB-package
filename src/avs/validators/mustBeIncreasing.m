function mustBeIncreasing(V, allowEqual)
% MUSTBEINCREASING Validate that values in a vector are increasing
%
%   MUSTBEINCREASING(A, ALLOWEQUAL) throws an error if values in A are not
%   increasing from an element to element. If ALLOWEQUAL is set to "true",
%   the values may stay the same, but they still must not decrease.

arguments(Input)
    V
    allowEqual = false;
end

if ~(isnumeric(V) || islogical(V))
    throwAsCaller(MException( ...
        "mustBeIncreasing:nonNumericOrLogicalInput", ...
        "The input vector must be numeric or logical."));
end

if ~isreal(V)
    throwAsCaller(MException( ...
        "mustBeIncreasing:nonRealInput", ...
        "The input vector must be real."));
end

if ~(isvector(V) && (length(V) > 1))
    throwAsCaller(MException( ...
        "mustBeIncreasing:inputNotVector", ...
        "The input must be a vector."));
end

if ~(isscalar(allowEqual) && islogical(allowEqual))
    throwAsCaller(MException( ...
        "mustBeIncreasing:incorrectSecondInput", ...
        "The second input must be a logical scalar."));
end


dA = diff(V);
if(allowEqual)
    increasing = all((dA >= 0));
else
    increasing = all((dA >  0));
end

if ~increasing
    throwAsCaller(MException( ...
        "mustBeIncreasing:nonIncreasing", ...
        "Values in the input array must increase."));
end

end
