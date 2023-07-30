function show(this, sp, options)
% SHOW Shows signals spectra is the same axis
%
%   SHOW(THIS, SP1, ..., SPN, "LEGENDNAMES", ["NAME1", ... "NAMEN"])
%   creates a plot with parameters defined in THIS and show SP1, ..., SPN
%   spectra on it. Additionally shows the names of the spectra curves if
%   they are passed in the named argument.
%   This function performs no computation: it just shows.

arguments(Input)
    this (1,1) WelchSpectrumPlotter
end

arguments(Input, Repeating)
    sp (1,1) WelchSpectrum
end

arguments(Input)
    options.LegendNames {mustBeText} = "";
end

% Get the scale multiplier for the frequency axis and the name of its units
for i = length(sp):-1:1
    Fs(i) = sp{i}.Fs;
end
Fsmax = max(Fs);
[freqScale, freqUnits] = this.get_spectrum_freq_axis_params(Fsmax);

% Prepare axes labels
freqXlab = "Frequency, " + freqUnits;

switch this.plotMagnType
    case "Power"
        magnYlab = "Power";
    case "Amplitude"
        magnYlab = "Amplitude";
end

switch this.plotMagnUnits
    case "Linear"
    case "Decibels"
        magnYlab = magnYlab + ", dB";
end

if this.plotNormalizeMagn == "yes"
    magnYlab = magnYlab + " (norm.)";
end

switch this.plotPhsUnits
    case "Radians"
        phsYlab = "Phase, rad.";
    case "Degrees"
        phsYlab = "Phase, deg.";
end

% Prepare axes
figure;

if contains(this.plotType, "Magn")
    magnAx = axes();
    xlim(magnAx, this.xLim);
    ylim(magnAx, this.magnYLim);
    ylabel(magnAx, magnYlab);
    grid(magnAx, this.gridMode);
    xlabel(magnAx, freqXlab);
end

if contains(this.plotType, "Phase")
    phsAx = axes();
    xlim(phsAx, this.xLim);
    ylim(phsAx, this.phsYLim);
    ylabel(phsAx, phsYlab);
    grid(phsAx, this.gridMode);
    xlabel(phsAx, freqXlab);
end

if (this.plotType == "Magn&Phase")
    subplot(2, 1, 1, magnAx);
    xlabel("");
    subplot(2, 1, 2, phsAx);
end

for i = 1:length(sp)  
    % Format spectrum data
    f_i = sp{i}.freqGrid/freqScale;

    switch this.plotMagnType
        case "Power"
            switch this.plotMagnUnits
                case "Linear"
                    magn_i = sp{i}.power;
                case "Decibels"
                    magn_i = pow2db(sp{i}.power);
            end
        case "Amplitude"
            switch this.plotMagnUnits
                case "Linear"
                    magn_i = sqrt(sp{i}.power);
                case "Decibels"
                    magn_i = mag2db(sp{i}.power);
            end
    end

    if this.plotNormalizeMagn == "yes"
        switch this.plotMagnUnits
            case "Linear"
                magnNorm_i = magn_i/max(magn_i);
            case "Decibels"
                magnNorm_i = magn_i - max(magn_i);
        end
    else
        magnNorm_i = magn_i;
    end

    switch this.plotPhsUnits
        case "Radians"
            phs_i = sp{i}.phase;
        case "Degrees"
            phs_i = rad2deg(sp{i}.phase);
    end

    % Plot the lines
    if contains(this.plotType, "Magn")
        hold(magnAx, "on");
        plot(magnAx, f_i, magnNorm_i, "LineWidth", this.linesWidth);
        hold(magnAx, "off");
    end

    if contains(this.plotType, "Phase")
        hold(phsAx, "on");
        plot(phsAx, f_i, phs_i, "LineWidth", this.linesWidth);
        hold(phsAx, "off");
    end

end

if options.LegendNames ~= ""
    if contains(this.plotType, "Magn")
        legend(magnAx, options.LegendNames, ...
            "Location", this.legendLocation);
    end

    if contains(this.plotType, "Phase")
        legend(phsAx, options.LegendNames, ...
            "Location", this.legendLocation);
    end
end

end
