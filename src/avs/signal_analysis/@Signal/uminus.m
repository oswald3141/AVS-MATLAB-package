function r = uminus(a)
% UMINUS Negates the real part of each signal's sample
%
%    R = UMINUS(A) negates the real part of each sample of A. Leaves
%    "description" property of A unchanged.
%    This call also represents overloaded "unary minus" operator, so it can
%    be performed as
%       R = -A;

r = a;
n = numel(a);
for i = n:-1:1
    r(i).samples = -a(i).samples;
end

end
