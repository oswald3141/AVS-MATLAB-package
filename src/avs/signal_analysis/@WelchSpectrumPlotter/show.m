function show(this, sp, options)
% SHOW Shows signals spectra is the same axis
%
%   SHOW(THIS, SP1, ..., SPN, "LEGENDNAMES", ["NAME1", ... "NAMEN"])
%   creates a plot with parameters defined in THIS and shows SP1, ..., SPN
%   spectra on it. Additionally, shows the names of the spectra curves if
%   they are passed in the named argument.
%   This function performs no computation: it just shows.

arguments(Input)
    this (1,1) WelchSpectrumPlotter
end

arguments(Input, Repeating)
    sp (1,1) WelchSpectrum
end

arguments(Input)
    options.LegendNames (1,:) string = "";
end

% Get the scale multiplier for the frequency axis and the name of its units
for i = length(sp):-1:1
    Fs(i) = sp{i}.Fs;
end
Fsmax = max(Fs);
[freqScale, freqUnits] = ...
    WelchSpectrumPlotter.get_spectrum_freq_axis_params(Fsmax);

% Prepare axes labels
freqXlab = "Frequency, " + freqUnits;

switch this.MagnitudePlotType
    case "Power"
        magnYlab = "Power";
    case "Amplitude"
        magnYlab = "Amplitude";
end

switch this.MagnitudeUnits
    case "Linear"
    case "Decibels"
        magnYlab = magnYlab + ", dB";
end

if this.NormalizeMagnitude == "yes"
    magnYlab = magnYlab + " (norm.)";
end

switch this.PhaseUnits
    case "Radians"
        phsYlab = "Phase, rad.";
    case "Degrees"
        phsYlab = "Phase, deg.";
end

% Prepare axes
figure;

if contains(this.PlotType, "Magn")
    magnAx = axes();
    xlim(magnAx, this.XLim);
    ylim(magnAx, this.YLimMagnitude);
    ylabel(magnAx, magnYlab);
    grid(magnAx, this.GridMode);
    xlabel(magnAx, freqXlab);
end

if contains(this.PlotType, "Phase")
    phsAx = axes();
    xlim(phsAx, this.XLim);
    ylim(phsAx, this.YLimPhase);
    ylabel(phsAx, phsYlab);
    grid(phsAx, this.GridMode);
    xlabel(phsAx, freqXlab);
end

if (this.PlotType == "Magn&Phase")
    subplot(2, 1, 1, magnAx);
    xlabel("");
    subplot(2, 1, 2, phsAx);
end

for i = 1:length(sp)  
    % Format spectrum data
    f_i = sp{i}.freqGrid/freqScale;

    if this.OneSided == "auto" && sp{i}.isSymmetrical
        idx = f_i >= 0;
        f_i = f_i(idx);
        spPhs = sp{i}.phase(idx);
        spPwr = sp{i}.power(idx)*2;
    end

    switch this.MagnitudePlotType
        case "Power"
            switch this.MagnitudeUnits
                case "Linear"
                    magn_i = spPwr;
                case "Decibels"
                    spPwr(spPwr == 0) = realmin;
                    magn_i = pow2db(spPwr);
            end
        case "Amplitude"
            switch this.MagnitudeUnits
                case "Linear"
                    magn_i = sqrt(spPwr);
                case "Decibels"
                    spmag = sqrt(spPwr);
                    spmag(spmag == 0) = realmin;
                    magn_i = mag2db(spmag);
            end
    end

    if this.NormalizeMagnitude == "yes"
        switch this.MagnitudeUnits
            case "Linear"
                magnNorm_i = magn_i/max(magn_i);
            case "Decibels"
                magnNorm_i = magn_i - max(magn_i);
        end
    else
        magnNorm_i = magn_i;
    end

    switch this.PhaseUnits
        case "Radians"
            phs_i = spPhs;
        case "Degrees"
            phs_i = rad2deg(spPhs);
    end

    % Plot the lines
    if contains(this.PlotType, "Magn")
        hold(magnAx, "on");
        plot(magnAx, f_i, magnNorm_i, "LineWidth", this.LineWidth);
        hold(magnAx, "off");
    end

    if contains(this.PlotType, "Phase")
        hold(phsAx, "on");
        plot(phsAx, f_i, phs_i, "LineWidth", this.LineWidth);
        hold(phsAx, "off");
    end

end

if options.LegendNames ~= ""
    if contains(this.PlotType, "Magn")
        legend(magnAx, options.LegendNames, ...
            "Location", this.LegendLocation);
    end

    if contains(this.PlotType, "Phase")
        legend(phsAx, options.LegendNames, ...
            "Location", this.LegendLocation);
    end
end

end
