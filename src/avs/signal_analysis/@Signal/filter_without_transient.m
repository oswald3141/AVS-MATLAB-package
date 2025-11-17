function this = filter_without_transient(this, b, options)
% FILTER_WITHOUT_TRANSIENT Apply FIR filter minimizing transient effects
%
%   THIS = FILTER_WITHOUT_TRANSIENT(THIS, B, OPTIONS) calls
%   FILTER_WITHOUT_TRANSIENT from AVS for the signal's samples and updates
%   its sample rate if necessary.

arguments(Input)
    this (1,1) Signal
    b {mustBeVector, mustBeReal}

    options.InterpolationFactor (1,1) {mustBeInteger, mustBePositive} = 1
    options.DecimationFactor    (1,1) {mustBeInteger, mustBePositive} = 1    
    options.Algorithm {mustBeMember(options.Algorithm, ...
        ["zeropad", "matchinit"])} = ...
        "matchinit";
end

opts = namedargs2cell(options);
this.samples = filter_without_transient(b, this.samples, opts{:});
this.Fs = this.Fs*options.InterpolationFactor/options.DecimationFactor;

end
