function mustBeAngleWrappedTo(A, WV)
% MUSTBEANGLEWRAPPEDTO Validate that value is an angle wrapped to a value
%
%   MUSTBEANGLEWRAPPEDTO(A, WV) throws an error if A contains angles
%   not wrapped to WV.
%   The value of WV must be one of the following:
%       "pi"
%       "2pi"
%       "180"
%       "360"
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTBEANGLEINQUADRANT

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "AV:validators:mustBeNumericOrLogical", ...
        "Value must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "AV:validators:mustBeReal", ...
        "Value must be real."));
end

if ~(ischar(WV) && isrow(WV)) && ~(isstring(WV) && isscalar(WV))
    error("AV:validation:UnableToConvert", ...
        "Invalid argument at position 2. " + ...
        "Value must be 'pi', '2pi', '180', or '360'.");
end

switch string(WV)
    case "pi"
        bnd = [-pi pi];
    case "2pi"
        bnd = [0 2*pi];
    case "180"
        bnd = [-180 180];
    case "360"
        bnd = [0 360];
    otherwise
        error("AV:validation:UnableToConvert", ...
            "Invalid argument at position 2. " + ...
            "Value must be 'pi', '2pi', '180', or '360'.");
end

if ~all( (A >= bnd(1)) & (A <= bnd(2)), "all")
    throwAsCaller(MException( ...
        "AV:validators:mustBeAngleWrappedTo", ...
        "Value must be an angle wrapped to %s.", WV...
    ));
end

end
