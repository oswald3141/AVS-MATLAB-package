function r = angle(a)
% ANGLE Phase of a signal
%
%   R = ANGLE(A) returns signal R samples of which are the phases of
%   the signal's A samples. If A is an array, the operation is performed
%   for each element in it.
%   Leaves the description of R empty.

arguments(Input)
    a Signal
end

N = numel(a);

for i = N:-1:1
    r(i) = Signal(angle(a(i).samples), a(i).Fs, "");
end

r = reshape(r, size(a));

end
