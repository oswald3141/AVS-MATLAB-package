function a = abs(a)
% ABS Absolute value of a signal
%
%   A = ABS(A) returns a signal, whose samples are replaced with theie
%   absolute values.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

for i = 1:numel(a)
    a(i).samples = abs(a(i).samples);
end

end
