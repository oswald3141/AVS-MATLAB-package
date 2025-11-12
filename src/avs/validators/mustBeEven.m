function mustBeEven(A)
% MUSTBEEVEN Validate that value is even
%
%   MUSTBEEVEN(A) throws an error is A contains odd numbers.
%
%   See also: MUSTBEODD, MUSTBEEVENPOWEROFTWO, MUSTBENATURALPOWEROFTWO

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "mustBeEven:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeEven:nonRealInput", ...
        "The input must be real."));
end

if ~all(mod(A,2) == 0, "all")
    throwAsCaller(MException( ...
        "mustBeEven:notEven", ...
        "The array must contain only even numbers." ...
    ));
end

end
