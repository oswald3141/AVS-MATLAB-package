function mustBeAngleInQuadrant(A, Q)
% MUSTBEANGLEINQUADRANT Validate that value in an angle from a quadrant
%
%   MUSTBEANGLEINQUADRANT(A, Q) throws an error if a value in A is not an
%   angle from one of the quadrants specified in Q. Q must be an integer
%   quadrant number from 1 to 4. All angles in A must be wrapped to the
%   same range.
%
%   See also: MUSTBEANGLEWRAPPEDTO


if ~(isnumeric(A) || islogical(A))
    throwAsCaller(MException( ...
        "mustBeAngleInQuadrant:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeAngleInQuadrant:nonRealInput", ...
        "The input must be real."));
end

if ~(...
        (isnumeric(Q) || islogical(Q)) && ...
        isreal(Q) && ...
        isvector(Q) && ...
        all(ismember(Q, [1 2 3 4])))
    throwAsCaller(MException( ...
        "mustBeAngleInQuadrant:invalidQuadrantNumber", ...
        "The quandrant number must be an integer between 1 and 4." ...
    ));
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
        "mustBeAngleInQuadrant:invalidAngles", ...
        "All input angles must be correctly wrapped to the same range." ...
    ));
end

for iq = length(Q):-1:1
    bnd = qBnd{Q(iq)};
    inq(iq) = all( (A >= bnd(1)) & (A <= bnd(2)), "all");
end

quadList = sprintf('%i, ', Q);
quadList = quadList(1:end-2);

if ~any(inq)
    throwAsCaller(MException( ...
        "mustBeAngleInQuadrant:notAngleInQuadrant", ...
        "The input must be an angle in one of the " + ...
        "following quadrants: " + quadList + "." ...
    ));
end

end
