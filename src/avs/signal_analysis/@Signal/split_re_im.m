function [sre, sim] = split_re_im(this)
% SPLIT_RE_IM Create separate signals from Re and Im parts
%
%   [SRE, SIM] = SPLIT_RE_IM(THIS) creates two signals from THIS. SRE
%   contains the real component of THIS and SIM contains the imaginary
%   component of THIS. Other properties are copied from THIS.

arguments(Input)
    this (1,1) Signal
end

sre = this.apply(@real);
sim = this.apply(@imag);

end
