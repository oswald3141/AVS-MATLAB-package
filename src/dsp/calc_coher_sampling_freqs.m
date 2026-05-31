function [fcin, fcs] = calc_coher_sampling_freqs(fin, fs, nrec, sigfig)
% CALC_COHER_SAMPLING_FREQS Calculate frequencies for coherent sampling
%
%   [FCIN, FCS] = CALC_COHER_SAMPLING_FREQS(FIN, FS, NREC, SIGFIG)
%   recalculates input frequency FIN and sampling frequency FS to make them
%   suitable for coherent sampling with record length NREC. SIGFIG is an
%   optional parameter controlling the number of digits in the fractional
%   part.
%
%   See https://www.analog.com/en/resources/design-notes/coherent-sampling-calculator-csc.html
%   for further details.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    fin (1,1) {mustBeNonnegative}
    fs (1,1) {mustBePositive}
    nrec (1,1) {mustBePositive, mustBeInteger}
    sigfig (1,1) {mustBeNonnegative, mustBeInteger} = 4;
end

fbin = fs/nrec;
fcbin = round(fbin, sigfig);
fcs = round(fcbin*nrec, sigfig);
nwin = fin/fcs*nrec;
ncwin = 2*floor( (floor(nwin) + 1) / 2 ) + 1; % to closest (next) odd
fcin = round(fcs*ncwin/nrec, sigfig);

end
