function r = sum(a)
% SUM Sums signals in a vector
%
%   R = SUM(A) adds together the samples of all the signals in A. The
%   signals must have the same length and sample rate.
%   Leaves the description of R empty.

arguments(Input)
    a (1,:) Signal % sum for matricies is not implemented yet
end

aFs = [a.Fs];
aN = [a.n];

assert(all(aFs == aFs(1), "all"), ...
    "Signal:sum:mustHaveSameFs", ...
    "Addition of dignals with different sample rates is not possible.");

assert(all(aN == aN(1), "all"), ...
    "Signal:sum:mustHaveSameLengths", ...
    "Addition of dignals with different lengths is not possible.");

aSamples = reshape([a.samples], [], numel(a)).';
rSamples = sum(aSamples, 1);
r = Signal(rSamples, a(1).Fs, "");

end
