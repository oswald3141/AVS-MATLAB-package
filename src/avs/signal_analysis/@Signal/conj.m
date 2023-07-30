function r = conj(a)
% CONJ Conjugates all samples in a signal
%
%    R = CONJ(A) negates the imaginary part of each sample of A. Leaves
%    "description" property of A unchanged.

r = a;
n = numel(a);
for i = n:-1:1
    r(i).samples = conj(a(i).samples);
end

end
