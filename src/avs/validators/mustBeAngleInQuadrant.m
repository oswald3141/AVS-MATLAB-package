function mustBeAngleInQuadrant(A, Q)
% MUSTBEANGLEINQUADRANT Validate that value in an angle from a quadrant
%
%   MUSTBEANGLEINQUADRANT(A, Q) throws an error if A contains angles
%   outside the quadrants specified in Q. Q must be a vector with integer
%   quadrant numbers from 1 to 4. Values in A must be all wrapped to the
%   same range, e.g [0; 2pi], [0; 360], [-pi; pi], or [-180; 180].
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTBEANGLEWRAPPEDTO

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

if ~isnumeric(Q) && ~islogical(Q)
    throwAsCaller(MException( ...
        "AVS:validatorUsage:nonNumericOrLogicalInput", ...
        "Quadrant number must be numeric or logical."));
end

if ~isreal(Q)
    throwAsCaller(MException( ...
        "AVS:validatorUsage:nonRealInput", ...
        "Quadrant number must be real."));
end

if ~isvector(Q)
    throwAsCaller(MException( ...
        "AVS:validatorUsage:nonVectorInput", ...
        "Quadrant number must be a 1-by-n vector or an n-by-1 vector."));
end


if ~allfinite(Q) || ~all(Q == floor(Q), 'all')
    throwAsCaller(MException( ...
        "AVS:validatorUsage:nonIntegerInput", ...
        "Quadrant number must be integer."));
end

if ~all(Q >= 1 & Q <= 4)
    throwAsCaller(MException( ...
        "AVS:validatorUsage:outOfRangeInput", ...
        "Quadrant number must be greater than or equal to 1, " + ...
        "and less than or equal to 4."));
end

if all(A >= 0 & A <= 360, "all")
    qBnd = {[0 90], [90 180], [180 270], [270 360]};
elseif all(A >= 0 & A <= 2*pi, "all")
    qBnd = {[0 pi/2], [pi/2 pi], [pi 3*pi/2], [3*pi/2 2*pi]};
elseif all(A >= -180 & A <= 180, "all")
    qBnd = {[0 90], [90 180], [-180 -90], [-90 0]};
elseif all(A >= -pi & A <= pi, "all")
    qBnd = {[0 pi/2], [pi/2 pi], [-pi -pi/2], [-pi/2 0]};
else
    throwAsCaller(MException( ...
        "AVS:validatorUsage:nonSameAngleWrap", ...
        "All values must be correctly wrapped to the same range." ...
    ));
end

for iq = length(Q):-1:1
    bnd = qBnd{Q(iq)};
    inq(iq) = all( (A >= bnd(1)) & (A <= bnd(2)), "all");
end

if ~any(inq)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeAngleInQuadrant", ...
        "Value must be in one of the " + ...
        "following quadrants: [%s].", num2str(Q)));
end

end
