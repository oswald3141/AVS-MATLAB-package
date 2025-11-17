function a = conj(a)
% CONJ Conjugate the samples
%
%   A = CONJ(A) negates the imaginary part of each sample of A.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

for i = 1:numel(a)
    a(i).samples = conj(a(i).samples);
end

end
