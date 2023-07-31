function r = are_coprime(a)
% ARE_COPRIME Check if numbers are pairwise coprime
%
%   R = ARE_COPRIME(A) returns true if the numbers in A are pairwise
%   coprime.
%
%   See also: GCD_N, LCM_N

arguments(Input)
    a (1,:) {mustBeInteger, mustBePositive}
end

na = length(a);

if na < 2
    r = [];
else
    r = true;
    for i = 1:na-1
        for j = i+1:na
            r = r & (gcd(a(i), a(j)) == 1);
        end
    end
end

end
