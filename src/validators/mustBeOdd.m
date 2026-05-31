function mustBeOdd(A)
% MUSTBEODD Validate that value is odd
%
%   MUSTBEODD(A) throws an error if A contains even numbers.
%   A value is odd if the remainder after division of it by 2
%   determined with mod is 1.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTBEEVEN, MUSTBEEVENPOWEROFTWO, MUSTBENATURALPOWEROFTWO

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

if ~all(mod(A,2) == 1, "all")
    throwAsCaller(MException( ...
        "AVS:validators:mustBeOdd", ...
        "Value must be odd." ...
    ));
end

end
