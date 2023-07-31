function out = design_lowpass_fir(fpass, fstop, pbRipple, sbAtt, options)
% DESIGN_LOWPASS_FIR Design a lowpass filter with restrictions on order
%
%   OUT = DESIGN_LOWPASS_FIR(FPASS, FSTOP, PBRIPPLE, SBATT) designs a
%   lowpass FIR filter with passband frequency FPASS, stopdand frequency
%   FSTOP, passband ripple PBRIPPLE, and stopband attenuation SBATT. Uses
%   MATLAB's built-in Parks-McClellan algorithm implementation DESIGNFILT.
%
%   Additional named arguments:
%       - "Fs" - sample rate
%       - "EvenOrder" - forces the filter's order to be even.
%       - "OrderDivisors" forces the filter's order to be an natural number
%       with specified divisors.
%       - "OutputType" - sets the type of output. "Coeffs" for an array
%       with coefficients, "Object" for digitalFilter object.
%
%   Note that the resulting frequency response may be better than the
%   requested one. This is especially important with "EvenOrder" and
%   "OrderDivisors" arguments, since the functions increases the filter's
%   order to meet the passed requirements.
%
%   See also: FILTER_WITHOUT_TRANSIENT

arguments
    fpass (1,1) {mustBePositive}
    fstop (1,1) {mustBePositive}
    pbRipple (1,1) {mustBePositive}
    sbAtt (1,1) {mustBePositive}

    options.Fs (1,1) {mustBePositive} = 2;
    options.EvenOrder (1,1) logical = true;
    options.OrderDivisors {mustBeVector, ...
        mustBeInteger, mustBePositive} = 1;
    options.OutputType {mustBeMember(options.OutputType, ...
        ["Object" "Coeffs"])} = "Object";
end

fltr0 = designfilt( ...
    "lowpassfir", ...
    "PassbandFrequency", fpass, ...
    "StopbandFrequency", fstop, ...
    "PassbandRipple", pbRipple, ...
    "StopbandAttenuation", sbAtt, ...
    "SampleRate", options.Fs ...
);

divs = options.OrderDivisors;
if options.EvenOrder
    divs = [divs 2];
end
div = lcm_n(divs);

if div == 1
    fltr = fltr0;
else
    adev = [...
        (db2mag(pbRipple)-1) / ...
            (db2mag(pbRipple)+1) ...
        db2mag(-sbAtt)];
    w = max(adev)./adev;
    n0 = length(fltr0.Coefficients) - 1;
    n = closest_mult(n0, div, "ceil");
    
    fltr = designfilt( ...
        "lowpassfir", ...
        "PassbandFrequency", fpass, ...
        "StopbandFrequency", fstop, ...
        "FilterOrder", n, ...
        "PassbandWeight", w(1), ...
        "StopbandWeight", w(2), ...
        "SampleRate", options.Fs ...
    );
end

if options.OutputType == "Object"
    out = fltr;
elseif options.OutputType == "Coeffs"
    out = fltr.Coefficients;
else
    assert(0);
end

end
