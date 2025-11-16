function r = almeq(a, b, abs_th, epsilon)
% ALMEQ Compare floating-point numbers for equality
%
%   R = ALMEQ(A, B) returnes true if A and B are approximately equal.
%   A and B must have the same type. "almeq" is short for "almost equal". 
%
%   R = ALMEQ(A, B, ABS_TH, EPSILON) uses the specified threshold ABS_THR
%   for the absolute comparison and scale factor EPSILON for the relative
%   comparison. EPSILON must be in the [eps(class(A)); 1] range.
%
%   Rationale:
%   Regular, bitwise comparison (with eq() or ==) may yield unexpected
%   result for floating point values due to the precision problems (for
%   instance, 4/3+1/3 == 7/3-2/3 wil return false in MATLAB).
%
%   Method: https://stackoverflow.com/a/32334103
%   Credits to P-Gn: https://stackoverflow.com/users/1735003/p-gn
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    a {mustBeReal, mustBeA(a, ["double" "single"])}
    b {mustBeReal, mustBeA(b, ["double" "single"]), ...
        mustHaveCompatibleSizes(b, a)}
    abs_th {mustBeNonnegative} = realmin(class(a));
    epsilon {mustBeLessThanOrEqual(epsilon,1)} = 128*eps(class(a));
end

if class(a) ~= class(b)
    error("almeq:invalidDatatype", ...
        "Variables must be of the same type.");
end

if epsilon < eps(class(a))
    error("almeq:invalidEpsilon", ...
        "Epsilon must not be lower then eps(%s)", class(a));
end

diff = abs(a - b);
norm = min(abs(a+b), realmax);
r = diff < max(abs_th, epsilon*norm);

end
