function mustBeIncreasing(A, flag)
% MUSTBEINCREASING Validate that values in a vector are increasing
%
%   MUSTBEINCREASING(A) throws an error if values in A are not increasing
%   from an element to element.
% 
%   MUSTBEINCREASING(A, FLAG) Optional flag FLAG indicate if consequtive
%   values in A are allowed to be the same. The value of the optional flag
%   must be "allow-equal".
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTBEDECREASING

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

if ~isvector(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeVector", ...
        "Value must be a 1-by-n vector or an n-by-1 vector."));
end

if isempty(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeNonempty", ...
        "Value must not be empty."));
end

allowEqual = false;
if nargin > 1
    if ~(ischar(flag) && isrow(flag)) && ...
                                        ~(isstring(flag) && isscalar(flag))
        error("AVS:validation:UnableToConvert", ...
            "Invalid argument at position 2. " + ...
            "Value must be 'allow-equal' or not specified.");
    end

    if strcmp(flag, "allow-equal")
        allowEqual = true;
    else
        error("AVS:validation:UnableToConvert", ...
            "Invalid argument at position 2. " + ...
            "Value must be 'allow-equal' or not specified.");
    end
end

if(allowEqual)
    if ~all((diff(A) >= 0))
        throwAsCaller(MException( ...
            "AVS:validators:mustBeIncreasing", ...
            "Values must increase or be equal."));
    end
else
    if ~all((diff(A) >  0))
        throwAsCaller(MException( ...
            "AVS:validators:mustBeIncreasing", ...
            "Values must increase."));
    end
end

end
