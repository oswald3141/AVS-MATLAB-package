function a = abs(a)
% ABS Absolute value of a signal
%
%   A = ABS(A) returns a signal, whose samples are the absolute values of
%   the signal's A samples.

for i = 1:numel(a)
    a(i).samples = abs(a(i).samples);
end

end
