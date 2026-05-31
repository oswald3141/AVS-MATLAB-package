function a = times_sig_sig(a, b)
mustHaveSameSizeAndSampleRate(a, b);
a.samples = a.samples.*b.samples;
end
