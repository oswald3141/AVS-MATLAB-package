function sp = welch(this, segmLengthOrAnalyzer)
% WELCH Returns Welch spectrum of a signal
%
%   SP = WELCH(THIS) returns a spectrum computed with a segment length
%   equal half of the Signal's length. Uses default values of
%   WelchSpectrumAnalyzer parameters.
%
%   SP = WELCH(THIS, SEGMENTLENGTH) returns a spectrum computed with the
%   specified segment length. Uses default values of WelchSpectrumAnalyzer
%   parameters.
%
%   SP = WELCH(THIS, ANALYZER) uses the passed WelchSpectrumAnalyzer object
%   to compute the spectrum.

arguments(Input)
    this (1,1) Signal
    segmLengthOrAnalyzer (1,1) = 0.5;
end

arguments(Output)
    sp (1,1) WelchSpectrum
end

if isa(segmLengthOrAnalyzer, "WelchSpectrumAnalyzer")
    sp = segmLengthOrAnalyzer.do(this);
elseif isnumeric(segmLengthOrAnalyzer) && (segmLengthOrAnalyzer > 0)
    an = WelchSpectrumAnalyzer("SegmentLenght", segmLengthOrAnalyzer);
    sp = an.do(this);
else
    throw(MException( ...
        "Signal:welch:unknownArgument", ...
        "The second argument must be a segment length or " + ...
            "WelchSpectrumAnalyzer class object."));
end

end
