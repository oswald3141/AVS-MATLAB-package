function plot(this, pltType)
% PLOT Plot the Welch spectrum
%
%   PLOT(THIS, PLTTYPE) plots the power spectrum (PLTTYPE = "Power"), phase
%   spectrum (PLTTYPE = "Power") or both (PLTTYPE = "Power&Phase") unsign
%   WelchSpectrumPlotter class with default constructor's arguments.

arguments(Input)
    this (1,1) WelchSpectrum
    pltType ...
        {mustBeMember(pltType, ...
            ["Power", "Phase", "Power&Phase"])} = ...
        "Power";
end

switch pltType % Adjust for WelchSpectrumPlotter
    case "Power"
        pltType = "Magnitude";
    case "Phase"
        pltType = "Phase";
    case "Power&Phase"
        pltType = "Magn&Phase";
    otherwise
        assert(0);
end

plotter = WelchSpectrumPlotter("PlotType", pltType);
plotter.show(this);

end
