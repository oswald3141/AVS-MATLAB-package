function mustBeEven(A)
% MUSTBEEVEN Validate that value is even
%
%   MUSTBEODD(A) throws an error if A contains odd numbers.
%   A value is even if the remainder after division of it by 2
%   determined with mod is 0.
%
%   See also: MUSTBEODD, MUSTBEEVENPOWEROFTWO, MUSTBENATURALPOWEROFTWO

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeNumericOrLogical", ...
        "Value must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeReal", ...
        "Value must be real."));
end

if ~all(mod(A,2) == 0, "all")
    throwAsCaller(MException( ...
        "AVS:validators:mustBeEven", ...
        "Value must be even." ...
    ));
end

end
