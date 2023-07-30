function r = power(a, b)
% POWER Raises signal into a given power
%
%    R = POWER(A, B) raises each sample of each element of A into a
%    corresponding power from B. B must be a numeric array. Performs
%    dimensions expansion if necessary.
%    R inherits "description" property of A unless it is numeric. In such a
%    case the property of B is inherited.
%    This call also represents overloaded "power" operator, so it can be
%    performed as
%       R = A.^B;

assert(isnumeric(b), ...
    "Signal:powerMustBeNumeric", ...
    "The power's type can be numeric only.");

r = apply_basic_bin_op(a, b, @power);

end
