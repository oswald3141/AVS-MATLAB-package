function mustBeBinary(A)
% MUSTBEBINARY Validate that value is binary
%
%   MUSTBEBINARY(A) throws an error if A contains any numbers other than
%   "0" or "1".
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

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

if ~allfinite(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeFinite", ...
        "Value must be finite."));
end

if ~all(A == 0 | A == 1, "all")
    throwAsCaller(MException( ...
        "AVS:validators:mustBeBinary", ...
        "Value must be binary, i.e. 0 or 1." ...
    ));
end

end
