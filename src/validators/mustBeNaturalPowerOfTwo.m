function mustBeNaturalPowerOfTwo(A)
% MUSTBENATURALPOWEROFTWO Validate that value is a natural power of 2
%
%   MUSTBENATURALPOWEROFTWO(A) throws an error if A contains numbers which
%   are not a natural power of 2.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTBEEVENPOWEROFTWO

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

if ~all(A > 0, 'all')
    throwAsCaller(MException( ...
        "AVS:validators:mustBePositive", ...
        "Value must be positive."));
end

if ~allfinite(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeFinite", ...
        "Value must be finite."));
end

if ~allfinite(A) || ~all(A == floor(A), 'all')
    throwAsCaller(MException( ...
        "AVS:validators:mustBeInteger", ...
        "Value must be integer."));
end

if ~all(bitand(A, A-1, "uint64"), "all")
    throwAsCaller(MException( ...
        "AVS:validators:mustBeNaturalPowerOfTwo", ...
        "Value must be a natural power of 2." ...
    ));
end
