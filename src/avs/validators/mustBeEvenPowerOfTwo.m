function mustBeEvenPowerOfTwo(A)
% MUSTBEEVENPOWEROFTWO Validate that value is an even power of 2
%
%   MUSTBEEVENPOWEROFTWO(A) throws an error if A contains numbers which are
%   not an even power of 2. For example, 2^-2, 2^4, 2^8 or 2^-8 will not
%   cause an error, while 2^3, 2^5, 2^7 or 2^-11 will.
%
%   See also: MUSTBENATURALPOWEROFTWO

if ~(isnumeric(A) || islogical(A))
    throwAsCaller(MException( ...
        "mustBeEvenPowerOfTwo:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeEvenPowerOfTwo:nonRealInput", ...
        "The input must be real."));
end

if ~all(A > 0, "all")
    throwAsCaller(MException( ...
        "mustBeEvenPowerOfTwo:nonPositiveInput", ...
        "The input must be positive."));
end

if ~allfinite(A)
    throwAsCaller(MException( ...
        "mustBeEvenPowerOfTwo:nonFiniteInput", ...
        "The input must be finite."));
end

p = log2(A);
powerIsEven = all(mod(p, 2) == 0, "all");

if ~powerIsEven
    throwAsCaller(MException( ...
        "mustBeEvenPowerOfTwo:notAnEvenPowerOfTwo", ...
        "The array must contain only the numbers which are an even " + ...
        "power of two." ...
    ));
end

end
