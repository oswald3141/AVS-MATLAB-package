function [scale, unitName] = get_spectrum_freq_axis_params(FsMax)
% GET_SPECTRUM_AXIS_PARAMS Return spectrum axis parameters
%   [SCALE, UNITNAME] = GET_SPECTRUM_AXIS_PARAMS(FSMAX) returns name of the
%   frequency units (Hz, kHz, MHz, GHz) and the corresponding scale factor.
%
%   This is the internal function of WelchSpectrumPlotter, its direct use
%   is discouraged.

fExp = 3*floor(log10(FsMax/2)/3);

if fExp < 0
    unitName = "Hz";
    scale = 10^0;
elseif fExp > 9
    unitName = "GHz";
    scale = 10^9;
else
    switch fExp
        case 0
            unitName = "Hz";
            scale = 10^0;
        case 3
            unitName = "kHz";
            scale = 10^3;
        case 6
            unitName = "MHz";
            scale = 10^6;
        case 9
            unitName = "GHz";
            scale = 10^9;
    end
end

end
