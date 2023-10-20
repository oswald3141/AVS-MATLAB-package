function r = abs(a)
% ABS Absolute value of a signal
%
%   R = ABS(A) returns signal R samples of which are the absolute values of
%   the signal's A samples. If A is an array, the operation is performed
%   for each element in it.
%   Leaves the description of R empty.

arguments(Input)
    a Signal
end

N = numel(a);

for i = N:-1:1
    r(i) = Signal(abs(a(i).samples), a(i).Fs, "");
end

r = reshape(r, size(a));

end
