function mustBeOdd(A)
% MUSTBEODD Validate that value is odd
%
%   MUSTBEODD(A) throws an error is A contains even numbers.
%
%   See also: MUSTBEEVEN, MUSTBEEVENPOWEROFTWO, MUSTBENATURALPOWEROFTWO

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "mustBeOdd:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeOdd:nonRealInput", ...
        "The input must be real."));
end

if ~all(mod(A,2) == 1, "all")
    throwAsCaller(MException( ...
        "mustBeOdd:notOdd", ...
        "The array must contain only odd numbers." ...
    ));
end

end
