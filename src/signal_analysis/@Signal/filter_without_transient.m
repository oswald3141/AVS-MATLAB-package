function this = filter_without_transient(this, b, options)
% FILTER_WITHOUT_TRANSIENT Apply a FIR filter minimizing transient effects
%
%   THIS = FILTER_WITHOUT_TRANSIENT(THIS, B, OPTIONS) filters the sample of
%   the input signal with FIR filter coefficients B minimizing the
%   transient effects at the beginning and end of the output signal
%   introduced by the filter.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

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
