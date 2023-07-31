function r = gcd_n(a)
% GCD_N Greatest common divisor of several numbers
%
%   R = GCD_N(A) computes GCD of all numbers in A.
%
%   See also: LCM_N

arguments(Input)
    a (1,:) {mustBeInteger, mustBePositive}
end

na = length(a);

if na < 2
    r = [];
else
    r = a(1);
    for i = na:-1:2
        r = gcd(r, a(i));
    end
end

end
