function mustBeAngleWrappedTo(A, wrapVal)
% MUSTBEANGLEWRAPPEDTO Validate that value in an angle wrapped to a value
%
%   MUSTBEANGLEWRAPPEDTO(A, WRAPVAL) throws an error if a value in A is
%   not an angle wrapped to WRAPVAL. WRAPVAL must be a string containing
%   "pi", "2pi", "180", or "360". "180" and "360" can also be passed as
%   numbers.
%
%   See also: MUSTBEANGLEINQUADRANT

if ~(isnumeric(A) || islogical(A))
    throwAsCaller(MException( ...
        "mustBeAngleWrappedTo:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeAngleWrappedTo:nonRealInput", ...
        "The input must be real."));
end

if ~( ...
        isequal(wrapVal, "pi") || ...
        isequal(wrapVal, "2pi") || ...
        isequal(wrapVal, "180") || ...
        isequal(wrapVal, "360") || ...
        isequal(wrapVal, 180) || ...
        isequal(wrapVal, 360))
    throwAsCaller(MException( ...
        "mustBeAngleWrappedTo:invalidWrapValue", ...
        "Wrap value must be a string with pi, 2pi, " + ...
            "180, 360 or a number equal to either 180 or 360." ...
    ));
end

switch string(wrapVal)
    case "pi"
        bnd = [-pi pi];
    case "2pi"
        bnd = [0 2*pi];
    case "180"
        bnd = [-180 180];
    case "360"
        bnd = [0 360];
    otherwise
        assert(0);
end

if ~all( (A >= bnd(1)) & (A <= bnd(2)), "all")
    throwAsCaller(MException( ...
        "mustBeAngleWrappedTo:notAngleWrappedTo", ...
        "The input must be an angle wrapped to " + string(wrapVal) + "."...
    ));
end

end
