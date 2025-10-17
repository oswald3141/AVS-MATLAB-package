function y = filter_without_transient(b, x, options)
% FILTER_WITHOUT_TRANSIENT Apply FIR filter minimizing transient effects
%
%   Y = FILTER_WITHOUT_TRANSIENT(B, X) filters the input signal X with
%   FIR filter coefficients B minimizing the transient effects at the
%   beginning and end of the output signal introduced by the filter.
%
%   The funtion also supports performing upsampling before the filtering
%   and downsampling after it. Use "InterpolationFactor" and
%   "DecimationFactor" options if you need this operations to be performed.
%
%   The function supports two transient minimization algorithms. The used
%   algorithm is determined by the "Algorithm" option.
%   "zeropad" just adds zeros at the beginning and end of the signal, and
%   removes them afterwards.
%   "matchinit" constructs a prefix and postfix for the signal from the
%   signal itself, aiming to ensure good initial conditions for the actual
%   signal filtering. The prefix and postfix are removed afterwards. The
%   same trick is used in MATLAB's interp, decimate and filtfilt.
%   "matchinit" generaly yields better results, though it may perform worse
%   than "zeropad" with noise-like signals.
%
%   Please note, that if the filter's order is odd (its length is even),
%   its group delay is fractional. Because of that, this function will
%   compensate for this delay imperfectly, leaving residual phase
%   distortion in the output signal.

arguments(Input)
    b {mustBeVector, mustBeReal}
    x {mustBeVector, mustBeNumeric}

    options.InterpolationFactor (1,1) {mustBeInteger, mustBePositive} = 1
    options.DecimationFactor    (1,1) {mustBeInteger, mustBePositive} = 1    
    options.Algorithm {mustBeMember(options.Algorithm, ...
        ["zeropad", "matchinit"])} = ...
        "matchinit";
end

L = options.InterpolationFactor;
M = options.DecimationFactor;

% Filter parameters
fltrLength = length(b);
fltrGrpDel = floor((fltrLength-1)/2);
transLengthIn = round(fltrGrpDel/L);

% Padding parameters
nPadPts = 2*transLengthIn;
dropPtsOutLeft  = (nPadPts + transLengthIn)*L;
dropPtsOutRight = transLengthIn*L;

% Check if signal length is enough for "matchinit"
if (options.Algorithm == "matchinit")
    assert( ...
        length(x) >= nPadPts+1, ...
        "filter_without_transient:signalTooShort", ...
        "The signal is too short to be filtered by this function " + ...
        "using ""matchinit"" algorithm.");
end

% Padding points preparation
if options.Algorithm == "matchinit"
    % Pad the data from left and right to ensure good initial conditions
    % for the filtaring of the actual signal
    % The idea is adopted from "interp"'s source code
    padPtsLeft  = 2*x(1)   - x(nPadPts+1 : -1 : 2);
    padPtsRight = 2*x(end) - x(end-1 : -1 : end-nPadPts);
elseif options.Algorithm == "zeropad"
    % Pad the signal with zeros
    padPtsLeft  = zeros(1, nPadPts);
    padPtsRight = zeros(1, nPadPts);
end

% Pad, upsample, filter, drop transient points
xPad = [padPtsLeft x padPtsRight];
xPadUp = upsample(xPad, L);
xPadFltr = filter(b, 1, xPadUp);
yUndec = xPadFltr(dropPtsOutLeft+1 : end-dropPtsOutRight);

% Decimate
y = yUndec(1:M:end);

end
