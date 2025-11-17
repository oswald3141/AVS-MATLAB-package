function a = uminus(a)
% UMINUS Negates the samples
%
%   A = UMINUS(A) negates the samples of A.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

for i = 1:numel(a)
    a(i).samples = -a(i).samples;
end

end
