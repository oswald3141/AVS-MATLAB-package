function r = rms(a)
% RMS Calculates root mean square of samples
%
%   R = RMS(A) returns RMS values of signals in A.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

r = zeros(size(a));
for i = 1:numel(a)
    r(i) = rms(a(i).samples);
end

end
