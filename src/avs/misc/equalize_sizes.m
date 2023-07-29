function [a, b] = equalize_sizes(a, b)
% EQUALIZE_SIZES Make sizes of compatible arrays equal
%
%    [A, B] = EQUALIZE_SIZES(A, B) repeats elements inside A and B to make
%    the arrays sizes equal. Throws an error if A and B are not compatible
%    for basic operations (.*, +, -, etc.)
%
%    The function is useful for operators overloading. Note, that it is by
%    far not as effective as implicit dimensions expansion performed by
%    MATLAB's basic operators.


as = size(a);
bs = size(b);

dn = length(as) - length(bs);

if dn >= 0
    bs = [bs ones(1, dn)];
else
    as = [as ones(1, -dn)];
end

ar = ones(size(as));
ar(as == 1) = bs(as == 1);

br = ones(size(bs));
br(bs == 1) = as(bs == 1);

asnew = as.*ar;
bsnew = bs.*br;

if ~isequal(asnew, bsnew)
    throw(MException("equalize_sizes:sizeDimensionsMustMatch", ...
        "Arrays have incompatible sizes for this operation."));
end

a = repmat(a, ar);
b = repmat(b, br);

end
