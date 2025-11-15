function a = angle(a)
% ANGLE Phase of a signal
%
%   A = ANGLE(A) returns a signal, whose samples are the phases of the
%   signal's A samples.

for i = 1:numel(a)
    a(i).samples = angle(a(i).samples);
end

end
