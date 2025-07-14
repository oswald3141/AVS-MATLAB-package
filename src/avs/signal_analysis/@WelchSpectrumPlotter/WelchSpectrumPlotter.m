classdef WelchSpectrumPlotter < matlab.mixin.Copyable
    % WelchSpectrumPlotter Plots WelchSpectrum objects
    %   This class allows to set up the plotter once and show spectra with
    %   the same plotting prameters. It supports plotting several spectra
    %   in the same axis.
    %
    %   See also: SIGNAL, WELCHSPECTRUM, WELCHSPECTRUMANALYZER

    properties
        % Type of the plot (magnitude, phase or both)
        PlotType {mustBeMember(PlotType, ...
            ["Magnitude", "Phase", "Magn&Phase"])} = "Magnitude"

        % Type of the magnitude plot (amplitude or power)
        MagnitudePlotType {mustBeMember(MagnitudePlotType, ...
            ["Amplitude", "Power"])} = "Power"
        % Magnitude units (linear of dB)
        MagnitudeUnits {mustBeMember(MagnitudeUnits, ...
            ["Linear", "Decibels"])} = "Decibels"
        % Controls if the magnitude is normalized before plotting
        NormalizeMagnitude {mustBeMember(NormalizeMagnitude, ...
            ["yes", "no"])} = "yes"
        % Controls if the spectrum is plotted as one-sided
        OneSided {mustBeMember(OneSided, ...
            ["auto", "no"])} = "auto"

        % Phase units (degrees or radians)
        PhaseUnits {mustBeMember(PhaseUnits, ...
            ["Radians", "Degrees"])} = "Radians"

        % Width of the lines on the plot
        LineWidth (1,1) {mustBePositive} = 1.0
        % Grid on the plot (on, off, minor)
        GridMode {mustBeMember(GridMode, ...
            ["on", "off", "minor"])} = "on"

        % Magnitude axes limits
        YLimMagnitude {mustBeAxisLimits} = "auto"
        % Phase axes limits
        YLimPhase {mustBeAxisLimits} = "auto"
        % Frequency axes limits
        XLim {mustBeAxisLimits} = "auto"

        % Legend location. Directly passed to MATLAB's "legend".
        LegendLocation {mustBeTextScalar} = "northeast"
    end

    methods(Access = public)
        % Show spectrum or several of them in the same axes
        %   Uses the parameters form this class, accepts only the legend
        %   entries names in "options".
        show(this, sp, options);

        % Constructs the object by storing the passes plot parameters
        function this = WelchSpectrumPlotter(options)
            arguments(Input)
                options.?WelchSpectrumPlotter
            end

            MetaToolsForConstructor.assign_properties(this, options);
        end
    end

    methods(Static, Access = private)
        % Return spectrum axis parameters
        [fScale, fUnits] = get_spectrum_freq_axis_params(Fs);
    end

end
