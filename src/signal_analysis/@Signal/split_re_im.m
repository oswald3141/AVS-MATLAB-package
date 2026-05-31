function [sre, sim] = split_re_im(this)
% SPLIT_RE_IM Create separate signals from the real and imaginary parts
%
%   [SRE, SIM] = SPLIT_RE_IM(THIS) creates two signals from THIS. SRE
%   contains the real component of THIS and SIM contains the imaginary
%   component of THIS. Other properties are copied from THIS.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    this (1,1) Signal
end

sre = this.apply(@real);
sim = this.apply(@imag);

end
