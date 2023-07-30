function r = filter_without_transient(this, b, options)
% FILTER_WITHOUT_TRANSIENT Apply FIR filter minimizing transient effects
%
%    R = FILTER_WITHOUT_TRANSIENT(THIS, B, OPTIONS) calls
%    FILTER_WITHOUT_TRANSIENT from AVS for the signal's samples and updates
%    its sample rate if necessary. Leaves "description" property of THIS
%    unchanged.

arguments(Input)
    this (1,1) Signal
    b {mustBeVector, mustBeReal}

    options.InterpolationFactor (1,1) {mustBeInteger, mustBePositive} = 1
    options.DecimationFactor    (1,1) {mustBeInteger, mustBePositive} = 1    
    options.Algorithm {mustBeMember(options.Algorithm, ...
        ["zeropad", "matchinit"])} = ...
        "matchinit";
end

r = this;
opts = namedargs2cell(options);
r.samples = filter_without_transient(b, this.samples, opts{:});
r.Fs = this.Fs*options.InterpolationFactor/options.DecimationFactor;

end
