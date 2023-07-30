function [pwr, phs, nSegm] = compute(this, s)
% COMPUTE Compute Welch spectrum of a Signal
%
%   This is the internal method called by the constructor after setting up
%   the main object's properties.

ptsStep = this.Nfft - this.numOverlapPts;
iStart = 1;
iEnd = iStart + this.Nfft - 1;
nBatch = 0;

powTrace = zeros(this.Nfft, 1);
phsTrace = zeros(this.Nfft, 1);

traceFuncs = dictionary( ...
    "Average", @(new, trc) trc + new, ...
    "MaxHold", @(new, trc) max([trc new], [], 2), ...
    "MinHold", @(new, trc) min([trc new], [], 2));

pow_trace_func = traceFuncs(this.powTraceFuncName);
phs_trace_func = traceFuncs(this.phsTraceFuncName);

spwin = this.get_spwin(this.Nfft);
spwinDcEnergy = mean(spwin)^2;

while iEnd <= s.n
    sBatched = s.samples(iStart:iEnd);

    % Perform window weighting
    sBatchedWin = sBatched(:).*spwin;

    % Calculate the amplitude and phase spectrum separately for each batch
    rawSp = fftshift(fft(sBatchedWin, this.Nfft)/this.Nfft);

    pow0 = rawSp.*conj(rawSp)/spwinDcEnergy;
    phs0 = angle(rawSp);

    powTrace = pow_trace_func(pow0, powTrace);
    phsTrace = phs_trace_func(phs0, phsTrace);

    % Increment counters
    iStart = iStart + ptsStep;
    iEnd  = iEnd  + ptsStep;
    nBatch = nBatch + 1;
end

if this.powTraceFuncName == "Average"
    powTrace = powTrace./nBatch;
end

if this.phsTraceFuncName == "Average"
    phsTrace = phsTrace./nBatch;
end

pwr = powTrace;
phs = phsTrace;
nSegm = nBatch;

end
