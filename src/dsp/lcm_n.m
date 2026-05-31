function r = lcm_n(a)
% LCM_N Least common multiple of several numbers
%
%   R = LCM_N(A) computes LCM of all numbers in A.
%
%   See also: GCD_N

arguments(Input)
    a (1,:) {mustBeInteger, mustBePositive}
end

na = length(a);

if na < 2
    r = [];
else
    r = a(1);
    for i = na:-1:2
        r = lcm(r, a(i));
    end
end

end
