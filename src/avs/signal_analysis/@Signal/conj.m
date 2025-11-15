function a = conj(a)
% CONJ Conjugates all samples in a signal
%
%   A = CONJ(A) negates the imaginary part of each sample of A.

for i = 1:numel(a)
    a(i).samples = conj(a(i).samples);
end

end
