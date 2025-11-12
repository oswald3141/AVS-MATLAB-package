function mustBeDecreasing(V, allowEqual)
% MUSTBEDECREASING Validate that values in a vector are increasing
%
%   MUSTBEDECREASING(A, ALLOWEQUAL) throws an error if values in A are not
%   decreasing from an element to element. If ALLOWEQUAL is set to "true",
%   the values may stay the same, but they still must not increase.

arguments(Input)
    V
    allowEqual = false;
end

if ~isnumeric(V) && ~islogical(V)
    throwAsCaller(MException( ...
        "mustBeDecreasing:nonNumericOrLogicalInput", ...
        "The input vector must be numeric or logical."));
end

if ~isreal(V)
    throwAsCaller(MException( ...
        "mustBeDecreasing:nonRealInput", ...
        "The input vector must be real."));
end

if ~(isvector(V) && (length(V) > 1))
    throwAsCaller(MException( ...
        "mustBeDecreasing:inputNotVector", ...
        "The input must be a vector."));
end

if ~(isscalar(allowEqual) && islogical(allowEqual))
    throwAsCaller(MException( ...
        "mustBeDecreasing:incorrectSecondInput", ...
        "The second input must be a logical scalar."));
end


dA = diff(V);
if(allowEqual)
    decreasing = all((dA <= 0));
else
    decreasing = all((dA <  0));
end

if ~decreasing
    throwAsCaller(MException( ...
        "mustBeDecreasing:nonDecreasing", ...
        "Values in the input array must decrease."));
end

end
