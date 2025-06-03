function varargout = do(this, sigs)
% DO Compute Welch spectra of signals
%
%   [SP1, ..., SPN] = DO(THIS, SIG1, ..., SIGN) computes Welch spectrum
%   for each signal (SIG1, ..., SIGN) with the options stored in this class
%   and returnes the results in the same order.

arguments(Input)
    this (1,1) WelchSpectrumAnalyzer
end

arguments(Input, Repeating)
    sigs (1,1) Signal
end

if nargout == 0 % Optimization
    return;
end

assert(xor( ...
    isempty(this.SegmentLenghtAbsolute), ...
    isempty(this.SegmentLengthRelative)), ...
    "WelchSpectrumAnalyzer:do:undeterminedSegmentLength", ...
    "One (and only one) of the segment length properties must be empty.");

assert(nargout <= nargin, ...
    "WelchSpectrumAnalyzer:do:invalidNumberOfOutputs", ...
    "The number of outputs cannot exceed the number of inputs.");

for i = nargout:-1:1

    ws = WelchSpectrum();
    ws.Fs = sigs{i}.Fs;
    ws.description = sigs{i}.description;
    ws.isSymmetrical = ~sigs{i}.isComplex;

    if ~isempty(this.SegmentLenghtAbsolute)
        ws.segmentLength = this.SegmentLenghtAbsolute;
    elseif ~isempty(this.SegmentLengthRelative)
        ws.segmentLength = round(sigs{i}.n*this.SegmentLengthRelative);
    else
        assert(0);
    end

    assert(ws.segmentLength > 0, ...
        "WelchSpectrumAnalyzer:do:tooSmallRelativeSegmLentgh", ...
        "The specified relative segment length is too small for " + ...
            "signal %i.", i);

    assert(ws.segmentLength <= sigs{i}.n, ...
        "WelchSpectrumAnalyzer:do:segmentLengthTooBig", ...
        "The segment length is too big for signal %i.", i);

    ws.numOverlapPts = floor(this.Overlap*ws.segmentLength);

    if this.Window == "custom"
        ws.get_spwin = this.CustomWindow;
    else
        [~, ws.get_spwin] = get_spectral_window(this.Window, []);
    end

    ws.powTraceFunc = this.PowTraceFunction;
    ws.phsTraceFunc = this.PhsTraceFunction;
    ws.window = this.Window;

    if sigs{i}.n > 0
        ws = WelchSpectrumAnalyzer.compute_spectrum(sigs{i}, ws);
        ws.freqGrid = ...
            ((-ws.segmentLength/2:ws.segmentLength/2-1) / ...
                ws.segmentLength*ws.Fs)';
    end

    varargout{i} = ws;
end

end
