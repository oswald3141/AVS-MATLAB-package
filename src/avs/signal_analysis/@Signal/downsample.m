function r = downsample(this, n, phase)
% DOWNSAMPLE Decrease sample rate by integer factor
%
%    R = DOWNSAMPLE(THIS, N, PHASE) calls DOWNSAMPLE from MATLAB's
%    standard library for the signal's samples and updates its sampling
%    rate. Leaves "description" property of THIS unchanged.

arguments(Input)
    this (1,1) Signal
    n (1,1) {mustBeInteger, mustBePositive}
    phase (1,1) {mustBeInteger, mustBeNonnegative} = 0
end

r = this;
r.samples = downsample(this.samples, n, phase);
r.Fs = this.Fs/n;

end
