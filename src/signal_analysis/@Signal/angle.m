function a = angle(a)
% ANGLE Phase angle of a signal
%
%   A = ANGLE(A) returns a signal, whose samples are replaced with their
%   phase angles.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

for i = 1:numel(a)
    a(i).samples = angle(a(i).samples);
end

end
