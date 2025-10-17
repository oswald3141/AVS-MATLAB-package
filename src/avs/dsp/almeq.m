function r = almeq(a, b, abs_th, epsilon)
% ALMEQ Compare double-precision floating-point numbers for equality
%
%   R = ALMEQ(A, B) returnes true if A and B are approximately equal.
%   Behaves the same as eq(), supports arrays.
%
%   R = ALMEQ(A, B, ABS_TH, EPSILON) uses the specified threshold ABS_THR
%   for absolute comparison and scale factor EPSILON for relative
%   comparison.
%
%   "almeq" is short for "almost equal".
%
%   Rationale:
%   Regular, bitwise comparison (with eq() or ==) may yield unexpected
%   result for floating point values due to the precision problems (for
%   instance, 4/3+1/3 == 7/3-2/3 wil return false in MATLAB).
%
%   Method:
%   See https://stackoverflow.com/a/32334103

arguments
    a double {mustBeReal}
    b double {mustBeReal, mustHaveSameSize(b, a, "allow-scalar")}
    abs_th {mustBeNonnegative} = realmin;
    epsilon {mustBeInRange(epsilon, 0, 1, "exclusive")} = 128*eps();
end

assert(epsilon >= eps());

diff = abs(a - b);
norm = min(abs(a+b), realmax);
r = diff < max(abs_th, epsilon*norm);

end
