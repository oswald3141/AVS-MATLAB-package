function a = uminus(a)
% UMINUS Negates the real part of each signal's sample
%
%   A = UMINUS(A) negates the real part of each sample of A.

for i = 1:numel(a)
    a(i).samples = -a(i).samples;
end

end
