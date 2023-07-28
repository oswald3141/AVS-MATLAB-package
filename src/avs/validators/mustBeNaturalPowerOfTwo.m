function mustBeNaturalPowerOfTwo(A)
% MUSTBENATURALPOWEROFTWO Validate that valueis a natural power of 2
%
%   MUSTBENATURALPOWEROFTWO(A) throws an error if A contains numbers which
%   are not a natural power of 2.
%
%   See also: MUSTBEEVENPOWEROFTWO

if ~(isnumeric(A) || islogical(A))
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:nonRealInput", ...
        "The input must be real."));
end

if ~all(A > 0, "all")
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:nonPositiveInput", ...
        "The input must be positive."));
end

if ~allfinite(A)
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:nonFiniteInput", ...
        "The input must be finite."));
end

if ~all(A == floor(A), "all")
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:nonIntegerInput", ...
        "The input must be integer."));
end

natPowerOf2 = ~any(bitand(A, A-1, "uint64"));

if ~natPowerOf2
    throwAsCaller(MException( ...
        "mustBeNaturalPowerOfTwo:notANaturalPowerOfTwo", ...
        "The array must contain only the numbers which are a " + ...
        "natural power of two." ...
    ));
end
