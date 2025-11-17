function this = downsample(this, n, phase)
% DOWNSAMPLE Decrease sample rate by integer factor
%
%   THIS = DOWNSAMPLE(THIS, N, PHASE) calls DOWNSAMPLE from MATLAB's
%   standard library for the signal's samples and updates its sample rate.

arguments(Input)
    this (1,1) Signal
    n (1,1) {mustBeInteger, mustBePositive}
    phase (1,1) {mustBeInteger, mustBeNonnegative} = 0
end

this.samples = downsample(this.samples, n, phase);
this.Fs = this.Fs/n;

end
