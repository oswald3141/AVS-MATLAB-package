function mustHaveSameSizeAndSampleRate(s1, s2)
% MUSTHAVESAMESIZEANDSAMPLERATE Validate that signals have same Fs and n

n1 = numel(s1.samples);
n2 = numel(s2.samples);

if n1 ~= n2 && n1 ~= 1 && n2 ~= 1
    throwAsCaller(MException( ...
        "Signal:arithmeticBinaryOpeation:mustBeCompatible", ...
        "Signals must have same length, but %1~=%2.", n1, n2));
end

Fs1 = s1.Fs;
Fs2 = s2.Fs;

if ~unsafe_almeq(Fs1, Fs2)
    throwAsCaller(MException( ...
        "Signal:arithmeticBinaryOpeation:mustBeCompatible", ...
        "Signals must have same sample rate, but %f~=%f.", Fs1, Fs2));
end

end
