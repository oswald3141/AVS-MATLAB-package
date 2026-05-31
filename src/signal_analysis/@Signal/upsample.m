function this = upsample(this, n, phase)
% UPSAMPLE Increase sample rate by integer factor
%
%   THIS = UPSAMPLE(THIS, N, PHASE) calls UPSAMPLE from MATLAB's standard
%   library for the signal's samples and updates its sample rate.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    this (1,1) Signal
    n (1,1) {mustBeInteger, mustBePositive}
    phase (1,1) {mustBeInteger, mustBeNonnegative} = 0
end

this.samples = upsample(this.samples, n, phase);
this.Fs = this.Fs*n;

end
