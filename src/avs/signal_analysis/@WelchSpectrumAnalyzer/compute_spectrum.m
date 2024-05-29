function spec = compute_spectrum(sig, spec)

arguments
    sig (1,1) Signal
    spec (1,1) WelchSpectrum
end

ptsStep = spec.segmentLength - spec.numOverlapPts;
iStart = 1;
iEnd = iStart + spec.segmentLength - 1;
nBatch = 0;

powTrace = zeros(spec.segmentLength, 1);
phsTrace = zeros(spec.segmentLength, 1);

traceFuncs = dictionary( ...
    "Average", @(new, trc) trc + new, ...
    "MaxHold", @(new, trc) max([trc new], [], 2), ...
    "MinHold", @(new, trc) min([trc new], [], 2));

pow_trace_func = traceFuncs(spec.powTraceFunc);
phs_trace_func = traceFuncs(spec.phsTraceFunc);

spwin = spec.get_spwin(spec.segmentLength);
spwinDcEnergy = mean(spwin)^2;

while iEnd <= sig.n
    sBatched = sig.samples(iStart:iEnd);

    % Perform window weighting
    sBatchedWin = sBatched(:).*spwin;

    % Calculate the amplitude and phase spectrum separately for each batch
    rawSp = fftshift(fft( ...
        sBatchedWin, spec.segmentLength)/spec.segmentLength);

    pow0 = rawSp.*conj(rawSp)/spwinDcEnergy;
    phs0 = angle(rawSp);

    powTrace = pow_trace_func(pow0, powTrace);
    phsTrace = phs_trace_func(phs0, phsTrace);

    % Increment counters
    iStart = iStart + ptsStep;
    iEnd  = iEnd  + ptsStep;
    nBatch = nBatch + 1;
end

if spec.powTraceFunc == "Average"
    powTrace = powTrace./nBatch;
end

if spec.phsTraceFunc == "Average"
    phsTrace = phsTrace./nBatch;
end

spec.power = powTrace;
spec.phase = phsTrace;
spec.nSegments = nBatch;

end
